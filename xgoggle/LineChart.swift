//
//  LineChart.swift
//  xgoggle
//
//  Created by David Fontenot on 4/19/16.
//  Copyright © 2016 David Fontenot. All rights reserved.
//

import UIKit
import SwiftCharts

func setupLineChart(view: UIView, colorWheel: [UIColor]) -> Chart?{
    //****janky fix bc if it takes too long to run it will even remove the chart we want
    view.subviews.forEach({ $0.removeFromSuperview() })
    //Line Graph Chart
    //**might need to start by removing the old chart subview from the linegraphview parent first
    let chartSettings = ChartSettings()
    chartSettings.leading = 10
    chartSettings.top = 10
    chartSettings.trailing = 20
    chartSettings.bottom = 10
    
//    let chartLine2 = [
//        (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0)], color: UIColor.redColor()),
//        (chartPoints: [(7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.blackColor()),
//        (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blueColor())
//    ]
    //**need function that calculates max and mins for axes
    //**maybe even calculates what the chart should increment by
    //let chartMaxHeight =
    
    let chartLine1 = [
        (chartPoints: [(0.0, 100.0), (20.0, 120.0)], color: colorWheel[0]),
        (chartPoints: [(20.0, 120.0),(30.0, 136.0), (50.0, 158.0), (60, 170.0)], color: colorWheel[1]),
        (chartPoints: [(60.0, 170.0),(70.0,192.0), (90.0, 195.0), (100, 170.0)], color: colorWheel[2]),
        (chartPoints: [(100.0, 170.0),(110.0, 137.0), (120, 120)], color: colorWheel[1])
    ]
    
    let chartConfig = ChartConfigXY(
        //**fit ends of graph
        //ChartSettings.top: 20,
        //ChartSettings.trailing: 20
        chartSettings: chartSettings,
        xAxisConfig: ChartAxisConfig(from: 0, to: 120, by: 120),
        yAxisConfig: ChartAxisConfig(from: 100, to: 220, by: 20),
        xAxisLabelSettings: ChartLabelSettings(fontColor: UIColor.whiteColor()),
        yAxisLabelSettings: ChartLabelSettings(fontColor: UIColor.whiteColor()),
        guidelinesConfig: GuidelinesConfig(lineColor: UIColor.whiteColor())
    )
    
    //**Can adjust points in graph by appending -- for some reason doing it all in a function return isnt really working might have to pass more than just copy to make the change
    //must use var instead of let for that
    //chartLine1.append((chartPoints: [(9.0, 10.6), (4.2, 5.1), (7.3, 3.0)], color: UIColor.redColor()))
    
    let chart = XGogglesLineChart(
        //this is a problem bc im setting height and width manually here
        frame: CGRectMake(10, 10, view.frame.width-20, view.frame.height-20),
        //frame: CGRectMake(0, 0, self.LineGraphView.frame.width, self.LineGraphView.frame.height),
        chartConfig: chartConfig,
        xTitle: "Time",
        yTitle: "Heart Rate",
        lines: chartLine1,
        color: UIColor.whiteColor()
    )
    
    view.addSubview(chart.view)
    //self.LineGraphView.frame = CGRectMake(self.LineGraphView.frame.origin.x, self.LineGraphView.frame.origin.y, self.LineGraphView.frame.width, chart.frame.height)
    //print(LineGraphView.frame)
    
    return chart
}

//**will need to implement functions that do things with the actual points we want to use 