//
//  FirebaseIssuesViewModel.swift
//  FirebaseIssuesDemoApp
//
//  Created by tanuj on 27/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit
import CoreData

class FirebaseIssuesViewModel: NSObject {
    var onDataFetch: ((_ listOfIssues: NSArray) -> Void)?
    
    func fetchFirebaseIssueList() {
        RefreshApiManager().loadDataCheck { [weak self] (isApiCallNeeded) in
            guard let weakSelf = self else { return }
            if isApiCallNeeded {
                //Call Api after every 24hrs
                weakSelf.apiCallForFirebaseIssuesList()
            } else {
                //Fetch data from core data
                fetchSavedFirebaseIssuesList()
            }
        }
    }
    
    private func apiCallForFirebaseIssuesList()
    {
        //Initiate FirebaseIssues Api Call
        ApiRequest().fetchFireBaseIssuesList(using: Constants.FIREBASE_ISSUE_API) {(data, error) in
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([FirebaseIssueAPIResponse].self, from: data)
                let sortedModel = model.sorted(by: { $0.number > $1.number })
                DispatchQueue.main.async {
                    self.saveFirebaseIssueListInCoreData(model: sortedModel)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    //Core data should only contain the current data and old data should be discarded
    private func saveFirebaseIssueListInCoreData(model:  [FirebaseIssueAPIResponse]) {
        self.deleteAllFirebaseIssueRecordFromCoreData { (isDeleted) in
            guard isDeleted else {
                self.fetchSavedFirebaseIssuesList()
                return
            }
        }
        
        guard  let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        guard !model.isEmpty else { return }
        for object in model {
            let medium = FirebaseIssuesList(context: context)
            medium.number =  Int32(object.number)
            medium.body =  object.body
            medium.title = object.title
            medium.comments_url = object.comments_url
            do {
                try context.save()
            } catch  {
                print("Failed to save data")
            }
        }
        self.fetchSavedFirebaseIssuesList()
    }
    
    private func deleteAllFirebaseIssueRecordFromCoreData(handler: @escaping(_ isDeleted: Bool) -> ()) {
        guard  let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let request: NSFetchRequest<FirebaseIssueList> = FirebaseIssueList.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request as! NSFetchRequest<NSFetchRequestResult>)
        let context = appDelegate.persistentContainer.viewContext
        do {
            try context.execute(batchDeleteRequest)
        } catch {
        }
    }
    
    //Fetch response from core data else load from API
    private func fetchSavedFirebaseIssuesList() {
        var firebaseIssuesList: [FirebaseIssuesList] = []
        do {
            firebaseIssuesList = try (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext.fetch(FirebaseIssuesList.fetchRequest())
            let listOfIssues:NSArray = firebaseIssuesList as NSArray
            if listOfIssues.count > 0 {
                onDataFetch?(listOfIssues as NSArray)
            }
            else{
                apiCallForFirebaseIssuesList()
            }
        }
        catch {
            print("Fetching Failed")
        }
    }
}
