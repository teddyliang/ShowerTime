//
//  GraphViewController.swift
//  ShowerTime
//
//  Created by Teddy Liang on 7/13/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Charts
import SwiftyUserDefaults
class GraphViewController: UIViewController {
    
    @IBOutlet weak var graphView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var waterUsed: UILabel!
    @IBOutlet weak var moneySpent: UILabel!
    @IBOutlet weak var averageTime: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    var startCountDate: NSDate?
    var pausedTime: NSDate?
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let timesArray = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        var index = 0
        var dict : [String:Double] = [:]
        while index < 6 {
        dict[months[index]] = timesArray[index]
        index += 1
        }
        let allTimes = Array(dict.values)
        let size = dict.count
        setChart(months, values: timesArray)
        totalWater(allTimes, dictSize: size)

    }
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            infoView.hidden = true
            graphView.hidden = false
        case 1:
            infoView.hidden = false
            graphView.hidden = true
        default:
            break; 
        }
    }
    @IBOutlet weak var lineChartView: LineChartView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view.
//        
//        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
//        let timesArray = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
//        var index = 0
//        var dic : [String:Double] = [:]
//        while index < 6 {
//            dic[months[index]] = timesArray[index]
//            index += 1
//        }
//        setChart(months, values: timesArray)
//        
//    }
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        let hello = defaults.doubleForKey("goalShower")
        let ll = ChartLimitLine(limit: Double(hello), label: "Target")
        lineChartView.rightAxis.removeAllLimitLines()
        lineChartView.rightAxis.addLimitLine(ll)

        
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Shower Time")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        lineChartView.descriptionText = ""
        lineChartDataSet.colors = [UIColor(red: 30/255, green: 126/255, blue: 240/255, alpha: 1)]
        lineChartView.xAxis.labelPosition = .Bottom
        lineChartView.animate(xAxisDuration: 3.0, yAxisDuration: 3.0)
        
        
    }
    func totalWater(times: [Double], dictSize: Int)
    {
        var sum : Double = 0;
        for index in 0..<dictSize{
            sum = sum + times[index]
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        let hello = defaults.doubleForKey("showerFlow")
        waterUsed.text = String(sum*hello)
        let checking = NSUserDefaults.standardUserDefaults()
        let another = checking.doubleForKey("roundedPrice")
        moneySpent.text = String(sum*hello*another)
        let roundedAverage = round(100*sum/Double(dictSize))/100
        averageTime.text = String(roundedAverage)
    }
    func getTimeCounted() -> NSTimeInterval {
        
        if (startCountDate == nil) {
            return 0
        }
        var countedTime: NSTimeInterval = NSDate().timeIntervalSinceDate(startCountDate!)
        if pausedTime != nil {
            let pauseCountedTime: NSTimeInterval = NSDate().timeIntervalSinceDate(pausedTime!)
            countedTime -= pauseCountedTime
        }
        return countedTime
    }

}