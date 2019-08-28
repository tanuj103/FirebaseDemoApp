//
//  FirebaseIssueDetailVC.swift
//  FirebaseIssuesDemoApp
//
//  Created by tanuj on 28/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit
private let FirebaseIssueDetailCellIdentifier = "firebaseIssueDetailCell";

class FirebaseIssueDetailVC: UIViewController {
    @IBOutlet weak var issueDetailTableView: UITableView!
    private var firebaseIssueDetailViewModel =  FirebaseIssueDetailViewModel()
    private var commentArray : NSArray = []
    var comments_url : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseIssueDetailViewModel.onDataFetch = { [weak self] (issueDetail: NSArray) in
            self?.reloadTableViewWithData(issueDetail: issueDetail)
        }
        //Call firebaseCommentsApi
        firebaseIssueDetailViewModel.apiCallForFirebaseIssueDetail(commentUrl: comments_url)
    }
    
    func reloadTableViewWithData(issueDetail: NSArray) {
        commentArray = issueDetail
        if commentArray.count==0
        {
            let alert = UIAlertController(title: "Alert", message: "Comments not available", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            DispatchQueue.main.async {
                self.issueDetailTableView.reloadData()
            }
        }
    }
}

//MARK: Tableview Delegate Method

extension FirebaseIssueDetailVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let firebaseIssueDetailCell = tableView.dequeueReusableCell(withIdentifier: FirebaseIssueDetailCellIdentifier, for: indexPath) as! FirebaseIssueDetailCell
        let firebaseDetailModel = commentArray[indexPath.row] as! FirebaseDetailModel
        firebaseIssueDetailCell.configTableViewCellUI(firebaseDetailModel: firebaseDetailModel)
        return firebaseIssueDetailCell
    }
}
