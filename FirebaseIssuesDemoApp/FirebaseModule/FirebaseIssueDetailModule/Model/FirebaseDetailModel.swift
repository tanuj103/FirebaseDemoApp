//
//  FirebaseDetailModel.swift
//  FirebaseIssuesDemoApp
//
//  Created by tanuj on 28/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit

struct FirebaseDetailModel: Codable {
    let body: String?
    let id: Int?
    let user : user
}

struct user: Codable {
    let login: String
    let avatar_url: String
}
