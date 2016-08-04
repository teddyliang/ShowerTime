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
    var weekDict : [String:Double] = [:]
    var monthDict : [String:Double] = [:]
    var yearDict : [String:Double] = [:]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        let dictBack = NSUserDefaults.standardUserDefaults()
//        let  timesDictionary = dictBack.objectForKey("TimeDictionary")

 //       setChart(months, values: timesArray)
//        totalWater(timesArray, dictSize: timesArray.count)

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
            break
        }
    }
    @IBAction func timeIndex(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let today = NSDate()
            var check = 0
            let dictBack = NSUserDefaults.standardUserDefaults()
            let  timesDictionary = dictBack.objectForKey("TimeDictionary") as? [String: Double] ?? [String: Double]()
            var currentDate: NSDate = NSDate()
            for index in 0..<7 {
                var dateComponents: NSDateComponents = NSDateComponents()
                dateComponents.day = -6+index
                var inTheWeek: NSDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: currentDate, options: [])!
                for dates in timesDictionary.keys
                {
                    let string = dates
                    var df: NSDateFormatter = NSDateFormatter()
                    df.dateFormat = "yyyy-MM-dd HH:mm:ss a "
                    var myDate: NSDate = df.dateFromString(string)!
                    var beforeDate = myDate
                    let beforeCalendar = NSCalendar.currentCalendar()
                    let beforeComponents = beforeCalendar.components([.Day , .Month , .Year], fromDate: beforeDate)
                    let beforeYear =  beforeComponents.year
                    let beforeMonth = beforeComponents.month
                    let beforeDay = beforeComponents.day
                    
                    let calendar = NSCalendar.currentCalendar()
                    let components = calendar.components([.Day , .Month , .Year], fromDate: inTheWeek)
                    
                    let year =  components.year
                    let month = components.month
                    let day = components.day
                    if year == beforeYear && month == beforeMonth && day == beforeDay
                    {
                        check = 1
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
                        //dateFormatter.timeZone = NSTimeZone()
                        let stringDate = dateFormatter.stringFromDate(inTheWeek)
                        let displayDay = "\(String(month))/\(String(day))"
                        weekDict[displayDay] = timesDictionary[stringDate]

                    }
                }
                if check == 0{
                    let calendar = NSCalendar.currentCalendar()
                    let components = calendar.components([.Day , .Month , .Year], fromDate: inTheWeek)
                    
                    let year =  components.year
                    let month = components.month
                    let day = components.day
                    let displayDay = "\(String(month))/\(String(day))"
                    weekDict[displayDay] = 0

                }
            }
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(weekDict, forKey: "WeekArray")
            let duration = Array(weekDict.values)
            let day = Array(weekDict.keys)
            setChart(day, values: duration)
            let arrayBack = NSUserDefaults.standardUserDefaults()
            let timesArray = arrayBack.objectForKey("TimeArray")
//            var actualTimes: [Double] = []
//            for index in 0..<7{
//                actualTimes[index] = timesArray![(timesArray?.count)!-6+index]
//            }
//            totalWater(actualTimes, dictSize: 7)

        case 1:
            let today = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Day , .Month , .Year], fromDate: today)
            let day = components.day
            var check = 0
            let dictBack = NSUserDefaults.standardUserDefaults()
            let  timesDictionary = dictBack.objectForKey("TimeDictionary") as? [String: Double] ?? [String: Double]()
            var currentDate: NSDate = NSDate()
            for index in 0..<day {
                var dateComponents: NSDateComponents = NSDateComponents()
                dateComponents.day = -(day-1)+index
                var inTheMonth: NSDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: currentDate, options: [])!
                for dates in timesDictionary.keys
                {
                    let string = dates
                    var df: NSDateFormatter = NSDateFormatter()
                    df.dateFormat = "yyyy-MM-dd HH:mm:ss a "
                    var myDate: NSDate = df.dateFromString(string)!
                    var beforeDate = myDate
                    let beforeCalendar = NSCalendar.currentCalendar()
                    let beforeComponents = beforeCalendar.components([.Day , .Month , .Year], fromDate: beforeDate)
                    let beforeYear =  beforeComponents.year
                    let beforeMonth = beforeComponents.month
                    let beforeDay = beforeComponents.day
                    
                    let calendar = NSCalendar.currentCalendar()
                    let components = calendar.components([.Day , .Month , .Year], fromDate: inTheMonth)
                    
                    let year =  components.year
                    let month = components.month
                    let day = components.day
                    if year == beforeYear && month == beforeMonth
                    {
                        check = 1
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
                        //dateFormatter.timeZone = NSTimeZone()
//                        let stringDate = dateFormatter.stringFromDate(inThe)
//                        let displayDay = "\(String(month))/\(String(day))"
//                        monthDict[displayDay] = timesDictionary[stringDate]
                        
                    }
                }
                if check == 0{
                    let calendar = NSCalendar.currentCalendar()
//                    let components = calendar.components([.Day , .Month , .Year], fromDate: inTheWeek)
                    
                    let year =  components.year
                    let month = components.month
                    let day = components.day
                    let displayDay = "\(String(month))/\(String(day))"
                    monthDict[displayDay] = 0
                    
                }
            }
            let duration = Array(monthDict.values)
            let realDay = Array(monthDict.keys)
            setChart(realDay, values: duration)
            let arrayBack = NSUserDefaults.standardUserDefaults()
            let timesArray = arrayBack.objectForKey("TimeArray")
//            var actualTimes: [Double] = []
//            for index in 0..<31{
//                actualTimes[index] = timesArray![(timesArray?.count)!-day+index]
//            }
//            totalWater(actualTimes, dictSize: actualTimes.count)
            
        case 2:
            let today = NSDate()
            let cal = NSCalendar.currentCalendar()
            let day = cal.ordinalityOfUnit(.Day, inUnit: .Year, forDate: today)
            var check = 0
            let dictBack = NSUserDefaults.standardUserDefaults()
            let  timesDictionary = dictBack.objectForKey("TimeDictionary") as? [String: Double] ?? [String: Double]()
            var currentDate: NSDate = NSDate()
            for index in 0..<day {
                var dateComponents: NSDateComponents = NSDateComponents()
                dateComponents.day = -(day-1)+index
                var inTheYear: NSDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: currentDate, options: [])!
                for dates in timesDictionary.keys
                {
                    let string = dates
                    var df: NSDateFormatter = NSDateFormatter()
                    df.dateFormat = "yyyy-MM-dd HH:mm:ss a "
                    var myDate: NSDate = df.dateFromString(string)!
                    var beforeDate = myDate
                    let beforeCalendar = NSCalendar.currentCalendar()
                    let beforeComponents = beforeCalendar.components([.Day , .Month , .Year], fromDate: beforeDate)
                    let beforeYear =  beforeComponents.year
                    let beforeMonth = beforeComponents.month
                    let beforeDay = beforeComponents.day
                    let calendar = NSCalendar.currentCalendar()
//                    let components = calendar.components([.Day , .Month , .Year], fromDate: inTheMonth)
                    
//                    let year =  components.year
//                    let month = components.month
//                    let day = components.day
//                    if year == beforeYear
//                    {
//                        check = 1
//                        let dateFormatter = NSDateFormatter()
//                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
//                        //dateFormatter.timeZone = NSTimeZone()
//                        let stringDate = dateFormatter.stringFromDate(inTheYear)
//                        let displayDay = "\(String(month))"
//                        yearDict[displayDay] = timesDictionary[stringDate]
//                        
//                    }
                }
                if check == 0{
                    let calendar = NSCalendar.currentCalendar()
                    let components = calendar.components([.Day , .Month , .Year], fromDate: inTheYear)
                    let month = components.month
                    let displayDay = "\(String(month))"
                    yearDict[displayDay] = 0
                    
                }
            }
            let duration = Array(yearDict.values)
            let realDay = Array(yearDict.keys)
            setChart(realDay, values: duration)
            let arrayBack = NSUserDefaults.standardUserDefaults()
            let timesArray = arrayBack.objectForKey("TimeArray")
//            var actualTimes: [Double] = []
//            for index in 0..<day{
//                actualTimes[index] = timesArray![(timesArray?.count)!-day+index]
//            }
//            totalWater(actualTimes, dictSize: actualTimes.count)

        default:
            break
        }
    }
    @IBOutlet weak var lineChartView: LineChartView!
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
//    func getTimeCounted() -> NSTimeInterval {
//        
//        if (startCountDate == nil) {
//            return 0
//        }
//        var countedTime: NSTimeInterval = NSDate().timeIntervalSinceDate(startCountDate!)
//        if pausedTime != nil {
//            let pauseCountedTime: NSTimeInterval = NSDate().timeIntervalSinceDate(pausedTime!)
//            countedTime -= pauseCountedTime
//        }
//        return countedTime
//    }

}