//
//  TimerViewController.swift
//  ShowerTime
//
//  Created by Teddy Liang on 7/13/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import MZTimerLabel

class TimerViewController: UIViewController {
    
    @IBOutlet weak var timer: MZTimerLabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        let timer_ = MZTimerLabel(label: timer, andTimerType:MZTimerLabelTypeStopWatch)
        timer_.timeFormat = "mm:ss"
        self.stopButton.enabled = false
        stopButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func startPauseResumeStopwatch(sender: AnyObject) {
        if timer.counting {
            timer.pause()
            startButton.setTitle("Resume", forState: .Normal)
        }
        else if startButton.titleForState(.Normal) == "Reset"{
            timer.reset()
            startButton.setTitle("Start", forState: .Normal)
            stopButton.setTitle("Stop", forState: .Normal)
            self.stopButton.enabled = false
            stopButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        }
        else {
            timer.start()
            startButton.setTitle("Pause", forState: .Normal)
            self.stopButton.enabled = true
            stopButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
            
        }
    }
    @IBAction func stopStopwatch(sender: AnyObject) {
        
        if timer.counting {
            stopButton.setTitle("Save", forState: .Normal)
            startButton.setTitle("Reset", forState: .Normal)
            timer.pause()
        }
        else if stopButton.titleForState(.Normal) == "Save"{
            //Add to an array
            stopButton.setTitle("Stop", forState: .Normal)
            startButton.setTitle("Start", forState: .Normal)
            timer.reset()
        }
        else if stopButton.titleForState(.Normal) == "Stop" && startButton.titleForState(.Normal) == "Resume"{
            startButton.setTitle("Reset", forState: .Normal)
            stopButton.setTitle("Save", forState: .Normal)
        }
        else
        {
            stopButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        }
    }
    @IBAction func minusFive(sender: AnyObject) {
        timer.addTimeCountedByTime(-5)
    }
    @IBAction func plusFive(sender: AnyObject) {
        timer.addTimeCountedByTime(5)
    }
    
    
    
}
