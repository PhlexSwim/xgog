//
//  ViewController.swift
//  xgoggle
//
//  Created by David Fontenot on 4/7/16.
//  Copyright © 2016 David Fontenot. All rights reserved.
//

import UIKit
import SwiftCharts

class ViewController: UIViewController, ARPieChartDelegate, ARPieChartDataSource {

    @IBOutlet weak var PieChartView: ARPieChart!
    @IBOutlet weak var PieChartView2: ARPieChart!
    @IBOutlet weak var LineGraphView: UIView!

    private var chart: Chart?

    internal var outerRadius: CGFloat = 0.0
    internal var innerRadius: CGFloat = 0.0
    internal var selectedPieOffset: CGFloat = 0.0
    internal var labelFont: UIFont = UIFont.systemFontOfSize(10)
    internal var showDescriptionText: Bool = false
    internal var animationDuration: Double = 1.0

    var dataItems: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.





        //Pie Chart
        PieChartView.delegate = self
        PieChartView.dataSource = self
        PieChartView.showDescriptionText = true

        PieChartView2.delegate = self
        PieChartView2.dataSource = self
        PieChartView2.showDescriptionText = true

        // Random Default Value
        let defaultItemCount = randomInteger(1, upper: 10)
        for _ in 1...defaultItemCount {
            dataItems.addObject(randomItem())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        PieChartView.reloadData()
        PieChartView2.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Line Graph Chart
        let chartConfig = ChartConfigXY(
            xAxisConfig: ChartAxisConfig(from: 2, to: 14, by: 2),
            yAxisConfig: ChartAxisConfig(from: 0, to: 14, by: 2)
        )

        let chart = LineChart(
            //this is a problem bc im setting height and width manually here
            frame: CGRectMake(10, 10, self.LineGraphView.frame.width-20, 260),
            //frame: CGRectMake(0, 0, self.LineGraphView.frame.width, self.LineGraphView.frame.height),
            chartConfig: chartConfig,
            xTitle: "Time",
            yTitle: "Heart Rate",
            lines: [
                (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.redColor()),
                (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blueColor())
            ]
        )
        self.chart = chart
        self.LineGraphView.addSubview(chart.view)
        //self.LineGraphView.frame = CGRectMake(self.LineGraphView.frame.origin.x, self.LineGraphView.frame.origin.y, self.LineGraphView.frame.width, chart.frame.height)
        print(LineGraphView.frame)
    }

    //Random Functions

    func randomColor() -> UIColor {
        let randomR: CGFloat = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let randomG: CGFloat = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let randomB: CGFloat = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        return UIColor(red: randomR, green: randomG, blue: randomB, alpha: 1)
    }

    func randomInteger(lower: Int, upper: Int) -> Int {
        return Int(arc4random_uniform(UInt32(upper - lower + 1))) + lower
    }

    func randomItem() -> PieChartItem {
        let value = CGFloat(randomInteger(1, upper: 10))
        let color = randomColor()
        let description = "\(value)"
        return PieChartItem(value: value, color: color, description: description)
    }

    // #Pie Chart implementation
    /**
    *  MARK: ARPieChartDelegate
    */
    func pieChart(pieChart: ARPieChart, itemSelectedAtIndex index: Int) {
        //let itemSelected: PieChartItem = dataItems[index] as! PieChartItem
        //selectionLabel.text = "Value: \(itemSelected.value)"
        //selectionLabel.textColor = itemSelected.color
    }

    func pieChart(pieChart: ARPieChart, itemDeselectedAtIndex index: Int) {
        //selectionLabel.text = "No Selection"
        //selectionLabel.textColor = UIColor.blackColor()
    }


    /**
    *   MARK: ARPieChartDataSource
    */
    func numberOfSlicesInPieChart(pieChart: ARPieChart) -> Int {
        return dataItems.count
    }

    func pieChart(pieChart: ARPieChart, valueForSliceAtIndex index: Int) -> CGFloat {
        let item: PieChartItem = dataItems[index] as! PieChartItem
        return item.value
    }

    func pieChart(pieChart: ARPieChart, colorForSliceAtIndex index: Int) -> UIColor {
        let item: PieChartItem = dataItems[index] as! PieChartItem
        return item.color
    }

    func pieChart(pieChart: ARPieChart, descriptionForSliceAtIndex index: Int) -> String {
        let item: PieChartItem = dataItems[index] as! PieChartItem
        return item.description ?? ""
    }


}

/**
*  MARK: Pie chart data item
*/
public class PieChartItem {

    /// Data value
    public var value: CGFloat = 0.0

    /// Color displayed on chart
    public var color: UIColor = UIColor.blackColor()

    /// Description text
    public var description: String?

    public init(value: CGFloat, color: UIColor, description: String?) {
        self.value = value
        self.color = color
        self.description = description
    }
}

