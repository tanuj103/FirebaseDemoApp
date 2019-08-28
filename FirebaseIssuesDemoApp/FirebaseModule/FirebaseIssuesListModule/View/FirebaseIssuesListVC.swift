//
//  FirebaseIssuesListVC.swift
//  FirebaseIssuesDemoApp
//
//  Created by tanuj on 27/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit
private let FirebaseIssueCellIdentifier = "firebaseIssueCell";

class FirebaseIssuesListVC: UIViewController {
    
    @IBOutlet weak var issuesTableView: UITableView!
    private var firebaseIssuesViewModel =  FirebaseIssuesViewModel()
    private var issuesArray : NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseIssuesViewModel.onDataFetch = { [weak self] (listOfIssues: NSArray) in
            self?.reloadTableViewWithIssues(listOfIssues: listOfIssues)
        }
        //Call firebaseIssueApi
        firebaseIssuesViewModel.fetchFirebaseIssueList()
    }
    
    //Load tableView with data
    func reloadTableViewWithIssues(listOfIssues: NSArray) {
        issuesArray = listOfIssues
        DispatchQueue.main.async {
            self.issuesTableView.reloadData()
        }
    }
}

//MARK: Tableview Delegate Method

extension FirebaseIssuesListVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issuesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let firebaseIssueCell = tableView.dequeueReusableCell(withIdentifier: FirebaseIssueCellIdentifier, for: indexPath) as! FirebaseIssueCell
        let getIssueAtIndexPath = issuesArray[indexPath.row] as! FirebaseIssuesList
        firebaseIssueCell.configTableViewCellUI(title: getIssueAtIndexPath.title, body: getIssueAtIndexPath.body)
        return firebaseIssueCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let getIssueAtIndexPath = issuesArray[indexPath.row] as! FirebaseIssuesList
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let firebaseIssueDetailVC =  storyboard.instantiateViewController(withIdentifier: "firebaseIssueDetailVC") as? FirebaseIssueDetailVC else { return }
        if let commentUrl = getIssueAtIndexPath.comments_url
        {
            firebaseIssueDetailVC.comments_url = commentUrl
        }
        self.navigationController?.pushViewController(firebaseIssueDetailVC, animated: true)
    }
}
