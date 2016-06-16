//
//  Timer.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/16/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import Foundation

class Timer {
    
    var off: Bool = true
    var timerString: String = "00:00"
    var inTimer = NSTimer()
    var counter = 0
    var startTime = NSTimeInterval()
    
    func start() {
        inTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
    }
    
    @objc func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= NSTimeInterval(seconds)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        timerString = "\(strMinutes):\(strSeconds)"
        
    }

    func stop() {
        inTimer.invalidate()
    }
}