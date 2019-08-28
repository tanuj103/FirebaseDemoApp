//
//  FirebaseModel.swift
//  FirebaseIssuesDemoApp
//
//  Created by tanuj on 27/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import Foundation
import CoreData
struct FirebaseIssueAPIResponse: Codable {
    let  body: String?
    let  number: Int
    let  title: String?
    let  comments_url: String?
}

class FirebaseIssueList: NSManagedObject {
    @NSManaged var  body: String?
    @NSManaged var  number: Int
    @NSManaged var  title: String?
    @NSManaged var  comments_url: String?
}

extension FirebaseIssueList {
    class func fetchRequest() -> NSFetchRequest<FirebaseIssueList> {
        return NSFetchRequest<FirebaseIssueList>(entityName: "FirebaseIssuesList")
    }
}
