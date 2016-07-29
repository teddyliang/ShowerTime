//
//  TimerViewController.swift
//  ShowerTime
//
//  Created by Teddy Liang on 7/13/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var gallonsUsed: UILabel!
    var count = 0;
    var timer: NSTimer?
    //var isPaused = true
    func counter() {
        count += 1
        let minutes = UInt8(count/60)
        let seconds = UInt8(count)
        timerLabel.text = "\(seconds)"
        if seconds > 9 {
            
            timerLabel.text = "\(minutes):\(seconds)"
            
        }
        else {
            
            timerLabel.text = "\(minutes):0\(seconds)"
            
        }
        let hi = NSUserDefaults.standardUserDefaults()
        let hello = hi.doubleForKey("showerFlow")
        gallonsUsed.text = "Gallons Used: \(Double(count)*(hello/60))"
//        var currentTime = NSDate.timeIntervalSinceReferenceDate()
//        
//        //Find the difference between current time and start time.
//        
//        var elapsedTime: NSTimeInterval = currentTime - startTime
//        
//        //calculate the minutes in elapsed time.
//        
//        let minutes = UInt8(elapsedTime / 60.0)
//        
//        elapsedTime -= (NSTimeInterval(minutes) * 60)
//        
//        //calculate the seconds in elapsed time.
//        
//        let seconds = UInt8(elapsedTime)
//        
//        elapsedTime -= NSTimeInterval(seconds)
//        
//        //find out the fraction of milliseconds to be displayed.
//        
//        let fraction = UInt8(elapsedTime * 100)
//        
//        //add the leading zero for minutes, seconds and millseconds and store them as string constants
//        
//        let strMinutes = String(format: "%02d", minutes)
//        let strSeconds = String(format: "%02d", seconds)
//        let strFraction = String(format: "%02d", fraction)
//        
//        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
//        let hi = NSUserDefaults.standardUserDefaults()
//        let hello = hi.doubleForKey("showerFlow")
//        timerLabel.text = " \(strMinutes):\(strSeconds)"
//        let gallonsUpdated = String(round(100*(Double(Int(strMinutes)!*60+Int(strSeconds)!)*(hello/60)))/100)
//        gallonsUsed.text = "Gallons Used: \(gallonsUpdated)"
}

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startPauseResumeStopwatch(sender: AnyObject) {
        if startButton.titleLabel?.text == "Start" {
//            // timer wasn't started, let's start it
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
            startButton.setTitle("Pause", forState: .Normal)
        }
        if startButton.titleLabel?.text == "Pause"
        {
            timer?.invalidate()
            startButton.setTitle("Resume", forState: .Normal)
        }
        if startButton.titleLabel?.text == "Resume"
        {
            startButton.setTitle("Pause", forState: .Normal)
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
        }
        if startButton.titleLabel?.text == "Cancel"
        {
            timer?.invalidate()
            count = 0
            timerLabel.text = "00:00"
        }
//            startTime = NSDate.timeIntervalSinceReferenceDate()
//            startButton.setTitle("Pause", forState: .Normal)
//
//            //isPaused = false
//        }
//        else if startButton.titleLabel?.text == "Cancel" {
//            // they pressed stop, let's reset the timer
//            timer = nil
//            //isPaused = true
//            startButton.setTitle("Start", forState: .Normal)
//
//        }
//        else if startButton.titleLabel?.text == "Pause" {
//            // timer is running, let's pause it
//            
//            //isPaused = true
//            startButton.setTitle("Resume", forState: .Normal)
//
//            timer?.invalidate()
//            timer = nil
//            
//        }
//        else if startButton.titleLabel?.text == "Resume" {
//            // timer is paused, let's start it
//            //isPaused = false
//            startButton.setTitle("Pause", forState: .Normal)
//            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
//
//        }
    }
    @IBAction func stopStopwatch(sender: AnyObject) {
        if stopButton.titleLabel?.text == "Stop"
        {
            timer?.invalidate()
            startButton.setTitle("Cancel", forState: .Normal)
            stopButton.setTitle("Save", forState: .Normal)
        }
        else if stopButton.titleLabel?.text == "Save"
        {
            
        }
//        if startButton.titleLabel?.text == "Pause" || startButton.titleLabel?.text == "Resume"{
//            timer?.invalidate()
//            //isPaused = true
//            startButton.setTitle("Cancel", forState: .Normal)
//            startButton.setTitle("Save", forState: .Normal)
//        }
    }
    
    
    
    
}
