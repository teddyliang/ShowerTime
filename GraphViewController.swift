//
//  GraphViewController.swift
//  ShowerTime
//
//  Created by Teddy Liang on 7/13/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController {
    
    @IBOutlet weak var graphView: UIView!
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let timesArray = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        setChart(months, values: timesArray)
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Shower Time")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        lineChartView.descriptionText = ""
        lineChartDataSet.colors = [UIColor(red: 30/255, green: 126/255, blue: 240/255, alpha: 1)]
        lineChartView.xAxis.labelPosition = .Bottom
        lineChartView.animate(xAxisDuration: 3.0, yAxisDuration: 3.0)
        let ll = ChartLimitLine(limit: 10, label: "Target")
        lineChartView.rightAxis.addLimitLine(ll)
    }

}