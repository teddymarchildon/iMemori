//
//  Records.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/20/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import Foundation

final class Records {
    
    static var appRecords = NSUserDefaults.standardUserDefaults()
    
    static var regularHighscore: Int? {
        return appRecords.valueForKey("regularHighestScore") as? Int
    }
    static var regularFastestTimeString: String? {
        return appRecords.valueForKey("regularFastestTimeString") as? String
    }
    
    static var regularFastestTimeInt: Int? {
        return appRecords.valueForKey("regularFastestTimeInt") as? Int
    }
    
    static var hardHighscore: Int? {
        return appRecords.valueForKey("hardHighestScore") as? Int
    }
    static var hardFastestTimeString: String? {
        return appRecords.valueForKey("hardFastestTimeString") as? String
    }
    
    static var hardFastestTimeInt: Int? {
        return appRecords.valueForKey("hardFastestTimeInt") as? Int
    }
    
    static func setRegularHighscore(newScore: Int) {
        appRecords.setValue(newScore, forKey: "regularHighestScore")
    }
    
    static func setRegularFastestTime(newTimeInt: Int, newTimeString: String) {
        appRecords.setValue(newTimeInt, forKey: "regularFastestTimeInt")
        appRecords.setValue(newTimeString, forKey: "regularFastestTimeString")
    }
    
    static func setHardHighscore(newScore: Int) {
        appRecords.setValue(newScore, forKey: "hardHighestScore")
    }
    
    static func setHardFastestTime(newTimeInt: Int, newTimeString: String) {
        appRecords.setValue(newTimeInt, forKey: "hardFastestTimeInt")
        appRecords.setValue(newTimeString, forKey: "hardFastestTimeString")
    }
    
}