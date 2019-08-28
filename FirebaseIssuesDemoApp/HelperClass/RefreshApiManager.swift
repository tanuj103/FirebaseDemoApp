//
//  RefreshApiManager.swift
//  FirebaseIssuesDemoApp
//
//  Created by tanuj on 27/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit

class RefreshApiManager: NSObject {
    
    // Condition to check issues are only fetched once in 24 hours
    func loadDataCheck(completion: (Bool) -> Void) {
        if isApiRefreshRequired() {
            UserDefaults.standard.set(Date(), forKey: "lastResponseDate")
            completion(true)
        } else {
            completion(false)
        }
    }

    private func isApiRefreshRequired() -> Bool {
        let lastResponseDate = UserDefaults.standard.object(forKey: "lastResponseDate")
        guard let lastRefreshDate = lastResponseDate as? Date else {
            return true
        }
        if calculateHours(from: lastRefreshDate) > 24 {
            return true
        } else {
            return false
        }
    }
    
    // Returns the calculated hours
    private func calculateHours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: Date()).hour ?? 0
    }
}
