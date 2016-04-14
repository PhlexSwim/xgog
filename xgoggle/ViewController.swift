//
//  ViewController.swift
//  xgoggle
//
//  Created by David Fontenot on 4/7/16.
//  Copyright © 2016 David Fontenot. All rights reserved.
//

//hi luke how's it going

import UIKit
import SwiftCharts

class ViewController: UIViewController, ARPieChartDelegate, ARPieChartDataSource {

    @IBOutlet weak var PieChartView: ARPieChart!
    @IBOutlet weak var PieChartView2: ARPieChart!
    @IBOutlet weak var LineGraphView: UIView!

    @IBOutlet weak var pieChartCircleView11: UIView!



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

        //might want to also do this in viewDidLayoutSubviews
        setupPieChart()

        makeCircleOnView(pieChartCircleView11, color: UIColor.redColor())
    }

    func makeCircleOnView(view: UIView, color: UIColor) {
        //need to calculate width and height of parent view to determine center point

        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 0,y: 0), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath

        //change the fill color
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        //you can change the line width
        shapeLayer.lineWidth = 3.0

        pieChartCircleView11.layer.addSublayer(shapeLayer)
    }

    func setupPieChart() {
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
        setupLineChart()
    }

    func setupLineChart() {
        //****janky fix bc if it takes too long to run it will even remove the chart we want
        self.LineGraphView.subviews.forEach({ $0.removeFromSuperview() })
        //Line Graph Chart
        //**might need to start by removing the old chart subview from the linegraphview parent first
        let chartSettings = ChartSettings()
        chartSettings.leading = 10
        chartSettings.top = 10
        chartSettings.trailing = 10
        chartSettings.bottom = 10
        let chartConfig = ChartConfigXY(
            //**fit ends of graph
            //ChartSettings.top: 20,
            //ChartSettings.trailing: 20
            chartSettings: chartSettings,
            xAxisConfig: ChartAxisConfig(from: 2, to: 14, by: 2),
            yAxisConfig: ChartAxisConfig(from: 0, to: 14, by: 2)
        )
        
        let chart = LineChart(
            //this is a problem bc im setting height and width manually here
            frame: CGRectMake(10, 10, self.LineGraphView.frame.width-20, self.LineGraphView.frame.height-20),
            //frame: CGRectMake(0, 0, self.LineGraphView.frame.width, self.LineGraphView.frame.height),
            chartConfig: chartConfig,
            xTitle: "Time",
            yTitle: "Heart Rate",
            lines: [
                (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0)], color: UIColor.redColor()),
                (chartPoints: [(7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.blackColor()),
                (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blueColor())
            ]
        )
        self.chart = chart

        self.LineGraphView.addSubview(chart.view)
        //self.LineGraphView.frame = CGRectMake(self.LineGraphView.frame.origin.x, self.LineGraphView.frame.origin.y, self.LineGraphView.frame.width, chart.frame.height)
        print(LineGraphView.frame)
    }

    //Random Functions -- **should probably move this to its own file

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

    // #Pie Chart implementation -- **should probably move this to its own file
    // **watch out for aspect ratio thingymabob for pie charts when we go to resize them
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

