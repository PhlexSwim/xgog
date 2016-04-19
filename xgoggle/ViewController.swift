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

class ViewController: UIViewController, ARPieChartDelegate, ARPieChartDataSource, ARPieChart2Delegate, ARPieChart2DataSource {

    @IBOutlet weak var PieChartView: ARPieChart!
    @IBOutlet weak var PieChartView2: ARPieChart2!
    @IBOutlet weak var LineGraphView: UIView!

    //make array of these views
    @IBOutlet weak var pieChartCircleView11: UIView!
    @IBOutlet weak var pieChartCircleView12: UIView!
    @IBOutlet weak var pieChartCircleView13: UIView!
    @IBOutlet weak var pieChartCircleView14: UIView!

    @IBOutlet weak var pieChartCircleView21: UIView!
    @IBOutlet weak var pieChartCircleView22: UIView!
    @IBOutlet weak var pieChartCircleView23: UIView!
    @IBOutlet weak var pieChartCircleView24: UIView!


    private var chart: Chart?

    internal var outerRadius: CGFloat = 0.0
    internal var innerRadius: CGFloat = 0.0
    internal var selectedPieOffset: CGFloat = 0.0
    internal var labelFont: UIFont = UIFont.systemFontOfSize(10)
    internal var showDescriptionText: Bool = false
    internal var animationDuration: Double = 1.0

    var colorWheel = [UIColor]()

    var dataItems: NSMutableArray = []
    var dataItems2: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


        self.colorWheel.append(UIColor(red: 242/255, green: 155/255, blue: 48/255, alpha: 1))
        self.colorWheel.append(UIColor(red: 242/255, green: 107/255, blue: 29/255, alpha: 1))
        self.colorWheel.append(UIColor(red: 191/255, green: 44/255, blue: 11/255, alpha: 1))
        self.colorWheel.append(UIColor(red: 115/255, green: 2/255, blue: 2/255, alpha: 1))

        self.colorWheel.append(UIColor(red: 127/255, green: 178/255, blue: 240/255, alpha: 1))
        self.colorWheel.append(UIColor(red: 78/255, green: 122/255, blue: 199/255, alpha: 1))
        self.colorWheel.append(UIColor(red: 30/255, green: 40/255, blue: 140/255, alpha: 1))
        self.colorWheel.append(UIColor(red: 22/255, green: 25/255, blue: 59/255, alpha: 1))

        //might want to also do this in viewDidLayoutSubviews
        setupPieChart()
        makeAllTheCircles()

    }

    func makeAllTheCircles() {
        makeCircleOnView(pieChartCircleView11, color: self.colorWheel[0])
        makeCircleOnView(pieChartCircleView12, color: self.colorWheel[1])
        makeCircleOnView(pieChartCircleView13, color: self.colorWheel[2])
        makeCircleOnView(pieChartCircleView14, color: self.colorWheel[3])
        makeCircleOnView(pieChartCircleView21, color: self.colorWheel[4])
        makeCircleOnView(pieChartCircleView22, color: self.colorWheel[5])
        makeCircleOnView(pieChartCircleView23, color: self.colorWheel[6])
        makeCircleOnView(pieChartCircleView24, color: self.colorWheel[7])
    }

    func makeCircleOnView(view: UIView, color: UIColor) {
        //****janky fix bc if it takes too long to run it will even remove the chart we want
        view.subviews.forEach({ $0.removeFromSuperview() })
        //need to calculate width and height of parent view to determine center point
        let circleX = view.frame.width / 2
        let circleY = view.frame.height / 2
        //let radius = view.frame.width / 2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: circleX,y: circleY), radius: CGFloat(0.7*circleX), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath

        //change the fill color
        shapeLayer.fillColor = color.CGColor
        //you can change the stroke color
        shapeLayer.strokeColor = color.CGColor
        //you can change the line width
        shapeLayer.lineWidth = 1.0

        view.layer.addSublayer(shapeLayer)
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
        //let defaultItemCount = randomInteger(1, upper: 10)
        let defaultItemCount = 4
        dataItems.addObject(PieChartItem(value: 1, color: self.colorWheel[0], description: "\(1.0)"))
        dataItems.addObject(PieChartItem(value: 3, color: self.colorWheel[1], description: "\(3.0)"))
        dataItems.addObject(PieChartItem(value: 2, color: self.colorWheel[2], description: "\(2.0)"))
        dataItems.addObject(PieChartItem(value: 5, color: self.colorWheel[3], description: "\(5.0)"))

        dataItems2.addObject(PieChartItem(value: 70, color: self.colorWheel[4], description: "\(70)"))
        dataItems2.addObject(PieChartItem(value: 30, color: self.colorWheel[5], description: "\(30)"))
        dataItems2.addObject(PieChartItem(value: 200, color: self.colorWheel[6], description: "\(200)"))
        dataItems2.addObject(PieChartItem(value: 50, color: self.colorWheel[7], description: "\(50)"))

//        for _ in 1...defaultItemCount {
//            dataItems.addObject(randomItem())
//        }
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

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.chart = setupLineChart(self.LineGraphView, colorWheel: self.colorWheel)
        //self.chart!.view.frame = CGRectMake(10, 10, self.LineGraphView.frame.width-20, self.LineGraphView.frame.height-20)
    }

    func makeArrayOfPoints() -> [([(Double, Double)], UIColor)] {

        return [
            (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0)], color: UIColor.redColor()),
            (chartPoints: [(7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.blackColor()),
            (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blueColor())
        ]
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

    /**
     *   MARK: ARPieChart2DataSource
     */
    func numberOfSlicesInPieChart2(pieChart: ARPieChart2) -> Int {
        return dataItems2.count
    }

    func pieChart2(pieChart: ARPieChart2, valueForSliceAtIndex index: Int) -> CGFloat {
        let item: PieChartItem = dataItems2[index] as! PieChartItem
        return item.value
    }

    func pieChart2(pieChart: ARPieChart2, colorForSliceAtIndex index: Int) -> UIColor {
        let item: PieChartItem = dataItems2[index] as! PieChartItem
        return item.color
    }

    func pieChart2(pieChart: ARPieChart2, descriptionForSliceAtIndex index: Int) -> String {
        let item: PieChartItem = dataItems2[index] as! PieChartItem
        return item.description ?? ""
    }

    // #Pie Chart implementation -- **should probably move this to its own file
    // **watch out for aspect ratio thingymabob for pie charts when we go to resize them
    /**
     *  MARK: ARPieChartDelegate
     */
    func pieChart2(pieChart: ARPieChart2, itemSelectedAtIndex index: Int) {
        //let itemSelected: PieChartItem = dataItems[index] as! PieChartItem
        //selectionLabel.text = "Value: \(itemSelected.value)"
        //selectionLabel.textColor = itemSelected.color
    }

    func pieChart2(pieChart: ARPieChart2, itemDeselectedAtIndex index: Int) {
        //selectionLabel.text = "No Selection"
        //selectionLabel.textColor = UIColor.blackColor()
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

