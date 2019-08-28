//
//  FirebaseIssueDetailCell.swift
//  FirebaseIssuesDemoApp
//
//  Created by tanuj on 28/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit
import SDWebImage

class FirebaseIssueDetailCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentBodyLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImageView.layer.cornerRadius = 4
    }

    func configTableViewCellUI(firebaseDetailModel: FirebaseDetailModel?) {
        userNameLabel.text = firebaseDetailModel?.user.login
        commentBodyLabel.text = firebaseDetailModel?.body
        
        userImageView.sd_setImage(with: URL(string: (firebaseDetailModel?.user.avatar_url)!), placeholderImage: UIImage(named: ""))
    }
}
