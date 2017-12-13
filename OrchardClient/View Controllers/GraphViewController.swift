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
    
    var userRepoName: String?
    
    @IBOutlet weak var chartView: LineChartView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        let githubCommits = GithubCommitsNetworkingLayer()
//        RepositoryName.repositoryName = self.userRepoName!
//        githubCommits.network(route: .user(), requestRoute: .get) { (data) in
//            guard let commits = try? JSONDecoder().decode(Commits.self, from: data) else {return}
//            print(commits)
//            self.commitArray = commits.all!
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("This is the commit array \(commitArray)")
        
        let githubCommits = GithubCommitsNetworkingLayer()
        RepositoryName.repositoryName = self.userRepoName!
        githubCommits.network(route: .user(), requestRoute: .get) { (data) in
            guard let commits = try? JSONDecoder().decode(Commits.self, from: data) else {return}
            print(commits)
            self.commitArray = commits.all!
        }
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var numbers = [Int]()
    
    var lineChart = [ChartDataEntry]()
    
    @IBAction func updateGraph(_ sender: Any) {
        for i in 0 ... (commitArray.count - 1) {
            print("HTis is i \(i)")
            let value = ChartDataEntry(x: Double(i), y: Double(commitArray[i]))
            lineChart.append(value)
        }
        
        let line1 = LineChartDataSet(values: lineChart, label: "Number")
        line1.colors = [UIColor.blue]
        data.addDataSet(line1)
        chartView.data = data
        chartView.chartDescription?.text = "My awesome Graph"
    }
    
}
