//
//  GraphViewController.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 12/10/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Charts

class GraphViewController: UIViewController {
    
    let data = LineChartData()
    
    var commitArray = [Int]()
    
    @IBOutlet weak var chartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        for i in commitArray {
            let value = ChartDataEntry(x: Double(i), y: Double(i))
            lineChart.append(value)
        }
        
        let line1 = LineChartDataSet(values: lineChart, label: "Number")
        line1.colors = [UIColor.blue]
        data.addDataSet(line1)
        chartView.data = data
        chartView.chartDescription?.text = "My awesome Graph"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var numbers = [Int]()
    
    var lineChart = [ChartDataEntry]()
    
    
}
