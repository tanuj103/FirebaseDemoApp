//
//  ApiRequest.swift
//  FirebaseIssuesDemoApp
//
//  Created by tanuj on 27/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit

class ApiRequest: NSObject {
    
    func fetchFireBaseIssuesList(using apiUrl: String, handler: @escaping(_ response: Data?, _ error: Error?) -> ()) {
        guard let firebaseUrl = URL(string: apiUrl) else {
            return
        }
        let task = URLSession.shared.dataTask(with: firebaseUrl) { (data, reposne, error) in
            if let error = error {
                handler(nil, error)
                return
            }
            if let data = data {
                handler(data, nil)
            }
        }
        task.resume()
    }
}
