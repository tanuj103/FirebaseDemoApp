//
//  FirebaseIssueCell.swift
//  FirebaseIssuesDemoApp
//
//  Created by tanuj on 27/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit

class FirebaseIssueCell: UITableViewCell {
    @IBOutlet weak var issueTitleLabel: UILabel!
    @IBOutlet weak var issueBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configTableViewCellUI(title: String? , body: String?) {
        if let firebaseIsuueTitle = title {
            issueTitleLabel.text = firebaseIsuueTitle as String
        }
        if var firebaseIssueBody = body {
            // first 140 characters of the issue body should be shown in the list
            if firebaseIssueBody.count > 140 {
                let extraCharacterCount = firebaseIssueBody.count - 140
                let range = firebaseIssueBody.index(firebaseIssueBody.endIndex, offsetBy: -extraCharacterCount)..<firebaseIssueBody.endIndex
                firebaseIssueBody.removeSubrange(range)
            }
            issueBodyLabel.text = firebaseIssueBody
        }
    }
}
