//
//  ViewController.swift
//  xgoggle
//
//  Created by David Fontenot on 4/7/16.
//  Copyright © 2016 David Fontenot. All rights reserved.
//

import UIKit
import SwiftCharts

class ViewController: UIViewController {

    @IBOutlet weak var LineGraphView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let chartConfig = ChartConfigXY(
            xAxisConfig: ChartAxisConfig(from: 2, to: 14, by: 2),
            yAxisConfig: ChartAxisConfig(from: 0, to: 14, by: 2)
        )
        print(LineGraphView.frame.origin)

        let chart = LineChart(
            frame: CGRectMake(0, 0, 300, 240),
            chartConfig: chartConfig,
            xTitle: "Time",
            yTitle: "Heart Rate",
            lines: [
                (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.redColor()),
                (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blueColor())
            ]
        )

        self.LineGraphView.addSubview(chart.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

