//
//  Records.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/20/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import Foundation

class Records {
    
    static var appRecords = NSUserDefaults.standardUserDefaults()
    
    static var highscore: Int? {
        return appRecords.valueForKey("highestScore") as? Int
    }
    static var fastestTimeString: String? {
        return appRecords.valueForKey("fastestTimeString") as? String
    }
    
    static var fastestTimeInt: Int? {
        return appRecords.valueForKey("fastestTimeInt") as? Int
    }
    
    static func setHighscore(newScore: Int) {
        appRecords.setValue(newScore, forKey: "highestScore")
    }
    
    static func setFastestTime(newTimeInt: Int, newTimeString: String) {
        appRecords.setValue(newTimeInt, forKey: "fastestTimeInt")
        appRecords.setValue(newTimeString, forKey: "fastestTimeString")
    }
    
}