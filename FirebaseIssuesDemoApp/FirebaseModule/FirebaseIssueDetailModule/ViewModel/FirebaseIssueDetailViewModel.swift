//
//  FirebaseIssueDetailViewModel.swift
//  FirebaseIssuesDemoApp
//
//  Created by tanuj on 28/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit

class FirebaseIssueDetailViewModel {
    var onDataFetch: ((_ issueDetail: NSArray) -> Void)?
    
    func apiCallForFirebaseIssueDetail(commentUrl : String)
    {
        //Initiate FirebaseIssueComment Api Call
        ApiRequest().fetchFireBaseIssuesList(using: commentUrl) {(data, error) in
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([FirebaseDetailModel].self, from: data)
                self.onDataFetch?(model as NSArray)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
