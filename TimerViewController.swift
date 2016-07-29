//
//  TimerViewController.swift
//  ShowerTime
//
//  Created by Teddy Liang on 7/13/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation
class TimerViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var gallonsUsed: UILabel!
    @IBOutlet weak var minusFive: UIButton!
    @IBOutlet weak var plusFive: UIButton!
    var count = 0;
    var timer: NSTimer?
    //var isPaused = true
    func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    var audioPlayer: AVAudioPlayer?
    
    func playSound(str:String) {
        let url = NSBundle.mainBundle().URLForResource(str, withExtension: "mp3")!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
            guard let audioPlayer = audioPlayer else { return }
            
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }

    func counter() {
        count += 1
        var minutes = Int(count/60)
        var seconds = count - minutes*60
        timerLabel.text = "\(seconds)"
        if count < 0
        {
            timerLabel.text = "00:00"
            count = 0
        }
        else if seconds > 9 && minutes > 9{
            
            timerLabel.text = "\(minutes):\(seconds)"
            
        }
        else if seconds > 9 && minutes < 9{
            timerLabel.text = "0\(minutes):\(seconds)"
        }
        else if seconds < 9 && minutes > 9{
            timerLabel.text = "\(minutes):0\(seconds)"
        }
        else {
            
            timerLabel.text = "0\(minutes):0\(seconds)"
            
        }
        let hi = NSUserDefaults.standardUserDefaults()
        let hello = hi.doubleForKey("showerFlow")
        if count > 0{
            gallonsUsed.text = "Gallons Used: \(round(100*(Double(count)*(hello/60)))/100)"
        }
        else {
            gallonsUsed.text = "Gallons Used: 0.00"
        }
        let hihi = NSUserDefaults.standardUserDefaults()
        let hellohello = hihi.doubleForKey("goalShower")*60
        let roundedhellohello = round(hellohello)
        if count > Int(roundedhellohello)
        {
            playSound("alarm")
        }
        

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        minusFive.setTitleColor(UIColor.grayColor(), forState: .Normal)
        plusFive.setTitleColor(UIColor.grayColor(), forState: .Normal)
        
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
            stopButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
            minusFive.setTitleColor(UIColor.blueColor(), forState: .Normal)
            plusFive.setTitleColor(UIColor.blueColor(), forState: .Normal)
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
            count = 0
            timerLabel.text = "00:00"
            gallonsUsed.text = "Gallons Used: 0.00"
            startButton.setTitle("Start", forState: .Normal)
            stopButton.setTitle("Stop", forState: .Normal)
            stopButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
            minusFive.setTitleColor(UIColor.grayColor(), forState: .Normal)
            plusFive.setTitleColor(UIColor.grayColor(), forState: .Normal)
        }
    }
    @IBAction func stopStopwatch(sender: AnyObject) {
        audioPlayer?.stop()
        if stopButton.titleLabel?.text == "Stop"
        {
            timer?.invalidate()
            startButton.setTitle("Cancel", forState: .Normal)
            stopButton.setTitle("Save", forState: .Normal)
        }
        else if stopButton.titleLabel?.text == "Save"
        {
            //Save count to dictionary
            //Save gallons used to a dictionary
            startButton.setTitle("Start", forState: .Normal)
            stopButton.setTitle("Stop", forState: .Normal)
            count = 0
            gallonsUsed.text = "Gallons Used: 0.00"
            timerLabel.text = "00:00"
            stopButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
            minusFive.setTitleColor(UIColor.grayColor(), forState: .Normal)
            plusFive.setTitleColor(UIColor.grayColor(), forState: .Normal)

            
        }
    }
    @IBAction func subtractFive(sender: AnyObject) {
        count = count - 10
        var minutes = Int(count/60)
        var seconds = count - minutes*60
        timerLabel.text = "\(seconds)"
        if count < 0{
            timerLabel.text = "00:00"
            count = 0
        }
        else if seconds > 9 && minutes > 9{
            
            timerLabel.text = "\(minutes):\(seconds)"
            
        }
        else if seconds > 9 && minutes < 9{
            timerLabel.text = "0\(minutes):\(seconds)"
        }
        else if seconds < 9 && minutes > 9{
            timerLabel.text = "\(minutes):0\(seconds)"
        }
        else {
            
            timerLabel.text = "0\(minutes):0\(seconds)"
            
        }
        let hi = NSUserDefaults.standardUserDefaults()
        let hello = hi.doubleForKey("showerFlow")
        if count > 0{
            gallonsUsed.text = "Gallons Used: \(round(100*(Double(count)*(hello/60)))/100)"
        }
        else {
            gallonsUsed.text = "Gallons Used: 0.00"
        }
    }
    @IBAction func addFive(sender: AnyObject) {
            count = count + 10
            var minutes = Int(count/60)
            var seconds = count - minutes*60
            timerLabel.text = "\(seconds)"
            if count < 0{
                timerLabel.text = "00:00"
                count = 0
            }
            else if seconds > 9 && minutes > 9{
                
                timerLabel.text = "\(minutes):\(seconds)"
                
            }
            else if seconds > 9 && minutes < 9{
                timerLabel.text = "0\(minutes):\(seconds)"
            }
            else if seconds < 9 && minutes > 9{
                timerLabel.text = "\(minutes):0\(seconds)"
            }
            else {
                
                timerLabel.text = "0\(minutes):0\(seconds)"
                
            }
            let hi = NSUserDefaults.standardUserDefaults()
            let hello = hi.doubleForKey("showerFlow")
            if count > 0{
                gallonsUsed.text = "Gallons Used: \(round(100*(Double(count)*(hello/60)))/100)"
            }
            else {
                gallonsUsed.text = "Gallons Used: 0.00"
                }
            }
}
