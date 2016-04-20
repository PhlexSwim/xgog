//
//  LineChart.swift
//  xgoggle
//
//  Created by David Fontenot on 4/19/16.
//  Copyright © 2016 David Fontenot. All rights reserved.
//

import UIKit
import SwiftCharts

//extension LineChart {
//    // Initializer for multiple lines
//    public convenience init(frame: CGRect, chartConfig: ChartConfigXY, xTitle: String, yTitle: String, lines: [ChartLine], color: UIColor) {
//        
//        let xValues = chartConfig.xAxisConfig.from.stride(through: chartConfig.xAxisConfig.to, by: chartConfig.xAxisConfig.by).map{ChartAxisValueDouble($0)}
//        let yValues = chartConfig.yAxisConfig.from.stride(through: chartConfig.yAxisConfig.to, by: chartConfig.yAxisConfig.by).map{ChartAxisValueDouble($0)}
//        
//        let xModel = ChartAxisModel(axisValues: xValues, lineColor: color, axisTitleLabel: ChartAxisLabel(text: xTitle, settings: chartConfig.xAxisLabelSettings))
//        let yModel = ChartAxisModel(axisValues: yValues, lineColor: color, axisTitleLabel: ChartAxisLabel(text: yTitle, settings: chartConfig.yAxisLabelSettings.defaultVertical()))
//        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartConfig.chartSettings, chartFrame: frame, xModel: xModel, yModel: yModel)
//        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
//        
//        let lineLayers: [ChartLayer] = lines.map {line in
//            let chartPoints = line.chartPoints.map {chartPointScalar in
//                ChartPoint(x: ChartAxisValueDouble(chartPointScalar.0), y: ChartAxisValueDouble(chartPointScalar.1))
//            }
//            
//            let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: line.color, animDuration: 0.5, animDelay: 0)
//            return ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
//        }
//        
//        let guidelinesLayer = GuidelinesDefaultLayerGenerator.generateOpt(xAxis: xAxis, yAxis: yAxis, chartInnerFrame: innerFrame, guidelinesConfig: chartConfig.guidelinesConfig)
//        
//        let view = ChartBaseView(frame: frame)
//        let layers: [ChartLayer] = [xAxis, yAxis] + (guidelinesLayer.map{[$0]} ?? []) + lineLayers
//        
//        super.init(
//            view: view,
//            layers: layers
//        )
//    }
//}

//
//  LineChart.swift
//  Examples
//
//  Created by ischuetz on 19/07/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

public class XGogglesLineChart: Chart {
    
    public typealias ChartLine = (chartPoints: [(Double, Double)], color: UIColor)
    
    // Initializer for single line
    public convenience init(frame: CGRect, chartConfig: ChartConfigXY, xTitle: String, yTitle: String, line: ChartLine, color: UIColor) {
        self.init(frame: frame, chartConfig: chartConfig, xTitle: xTitle, yTitle: yTitle, lines: [line], color: color)
    }
    
    // Initializer for multiple lines
    public init(frame: CGRect, chartConfig: ChartConfigXY, xTitle: String, yTitle: String, lines: [ChartLine], color: UIColor) {
        
        let xValues = chartConfig.xAxisConfig.from.stride(through: chartConfig.xAxisConfig.to, by: chartConfig.xAxisConfig.by).map{ChartAxisValueDouble($0, labelSettings: ChartLabelSettings(fontColor: color))}
        let yValues = chartConfig.yAxisConfig.from.stride(through: chartConfig.yAxisConfig.to, by: chartConfig.yAxisConfig.by).map{ChartAxisValueDouble($0, labelSettings: ChartLabelSettings(fontColor: color))}
        
        //let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont, fontColor: color)
        
        let xModel = ChartAxisModel(axisValues: xValues, lineColor: color, axisTitleLabel: ChartAxisLabel(text: xTitle, settings: chartConfig.xAxisLabelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, lineColor: color, axisTitleLabel: ChartAxisLabel(text: yTitle, settings: chartConfig.yAxisLabelSettings.defaultVertical()))
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartConfig.chartSettings, chartFrame: frame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        let lineLayers: [ChartLayer] = lines.map {line in
            let chartPoints = line.chartPoints.map {chartPointScalar in
                ChartPoint(x: ChartAxisValueDouble(chartPointScalar.0), y: ChartAxisValueDouble(chartPointScalar.1))
            }
            
            let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: line.color, animDuration: 0.5, animDelay: 0)
            return ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
        }
        
        let guidelinesLayer = GuidelinesDefaultLayerGenerator.generateOpt(xAxis: xAxis, yAxis: yAxis, chartInnerFrame: innerFrame, guidelinesConfig: chartConfig.guidelinesConfig)
        
        let view = ChartBaseView(frame: frame)
        let layers: [ChartLayer] = [xAxis, yAxis] + (guidelinesLayer.map{[$0]} ?? []) + lineLayers
        
        super.init(
            view: view,
            layers: layers
        )
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}








func setupLineChart(view: UIView, colorWheel: [UIColor]) -> Chart?{
    
    //LineChart implementation
//
//    let chartSettings = ChartSettings()
//    chartSettings.leading = 10
//    chartSettings.top = 10
//    chartSettings.trailing = 20
//    chartSettings.bottom = 10
//    
//    let chartConfig = ChartConfigXY(
//        //**fit ends of graph
//        //ChartSettings.top: 20,
//        //ChartSettings.trailing: 20
//        chartSettings: chartSettings,
//        xAxisConfig: ChartAxisConfig(from: 0, to: 120, by: 120),
//        yAxisConfig: ChartAxisConfig(from: 100, to: 220, by: 20)
//    )
//    
//    var chart = LineChart(frame: CGRectMake(10, 10, view.frame.width-20, view.frame.height-20), chartConfig: chartConfig, xTitle: "Time (minutes)", yTitle: "Heart Rate", lines: <#T##[ChartLine]#>)
//    
//    
//    
    //end that shit
    
    
    
    
    
    //****janky fix bc if it takes too long to run it will even remove the chart we want
    view.subviews.forEach({ $0.removeFromSuperview() })
    //Line Graph Chart
    //**might need to start by removing the old chart subview from the linegraphview parent first
    let chartSettings = ChartSettings()
    chartSettings.leading = 10
    chartSettings.top = 10
    chartSettings.trailing = 20
    chartSettings.bottom = 10
    
    let chartLine2 = [
        (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0)], color: UIColor.redColor()),
        (chartPoints: [(7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.blackColor()),
        (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blueColor())
    ]
    //**need function that calculates max and mins for axes
    //**maybe even calculates what the chart should increment by
    //let chartMaxHeight =
    
    let chartLine1 = [
        (chartPoints: [(0.0, 100.0), (20.0, 120.0)], color: colorWheel[0]),
        (chartPoints: [(20.0, 120.0),(30.0, 136.0), (50.0, 158.0), (60, 170.0)], color: colorWheel[1]),
        (chartPoints: [(60.0, 170.0),(70.0,192.0), (90.0, 195.0), (100, 170.0)], color: colorWheel[2]),
        (chartPoints: [(100.0, 170.0),(110.0, 137.0), (120, 120)], color: colorWheel[1])
    ]
    
//    let labelSettings = ChartLabelSettings(fontColor: UIColor.whiteColor())
//    
//    let xValues = Array(2.stride(through: 16, by: 2)).map {ChartAxisValueInt($0, labelSettings: labelSettings)}
//    let yValues = Array(0.stride(through: 20, by: 2)).map {ChartAxisValueInt($0, labelSettings: labelSettings)}
//    
//    let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
//    let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
    
    
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
    
    //new implementation
    
//    let labelSettings = ChartLabelSettings(font: UIFont(name: "Helvetica", size: 11) ?? UIFont.systemFontOfSize(11))
//    
//    let chartPoints = [(2, 2), (3, 1), (5, 9), (6, 7), (8, 10), (9, 9), (10, 15), (13, 8), (15, 20), (16, 17)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
//
//    let xValues = Array(2.stride(through: 16, by: 2)).map {ChartAxisValueInt($0, labelSettings: labelSettings)}
//    let yValues = Array(0.stride(through: 20, by: 2)).map {ChartAxisValueInt($0, labelSettings: labelSettings)}
//    
//    let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
//    let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
//    let chartFrame = CGRectMake(0, 70, view.bounds.size.width, view.bounds.size.height - 70)
//    
//    let chartSettings = ChartSettings()
//    chartSettings.leading = 10
//    chartSettings.top = 10
//    chartSettings.trailing = 20
//    chartSettings.bottom = 10
//    chartSettings.labelsToAxisSpacingX = 5
//    chartSettings.labelsToAxisSpacingY = 5
//    chartSettings.axisTitleLabelsToLabelsSpacing = 4
//    chartSettings.axisStrokeWidth = 0.2
//    chartSettings.spacingBetweenAxesX = 8
//    chartSettings.spacingBetweenAxesY = 8
//    
//    let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
//    let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
//    
//    // create layer with line
//    let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor(red: 0.4, green: 0.4, blue: 1, alpha: 0.2), lineWidth: 3, animDuration: 0.7, animDelay: 0)
//    let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
//    
//    // view generator - creates circle view for each chartpoint
//    let circleViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
//        return ChartPointCircleView(center: chartPointModel.screenLoc, size: CGSizeMake(20, 20), settings: ChartPointCircleViewSettings(animDuration: 0.5))
//    }
//    // create layer that uses the view generator
//    let chartPointsCircleLayer = ChartPointsViewsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, viewGenerator: circleViewGenerator, displayDelay: 0, delayBetweenItems: 0.05)
//    
//    // create layer with guidelines
//    var settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.whiteColor(), linesWidth: CGFloat(0.1), axis: .XAndY)
//    let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
//    
//    let chart = Chart(
//        frame: chartFrame,
//        layers: [
//            xAxis,
//            yAxis,
//            guidelinesLayer,
//            chartPointsLineLayer,
//            chartPointsCircleLayer
//        ]
//    )
    
    
    //end new implementation one
    
    //start new implementation 2
    
//    let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
//    
//    let chartPoints = [(2, 2), (3, 1), (5, 9), (6, 7), (8, 10), (9, 9), (10, 15), (13, 8), (15, 20), (16, 17)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
//    
//    let xValues = Array(2.stride(through: 16, by: 2)).map {ChartAxisValueInt($0, labelSettings: labelSettings)}
//    let yValues = Array(0.stride(through: 20, by: 2)).map {ChartAxisValueInt($0, labelSettings: labelSettings)}
//    
//    let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
//    let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
//    let chartFrame = ExamplesDefaults.chartFrame(view.bounds)
//    
//    let chartSettings = ExamplesDefaults.chartSettings
//    let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
//    let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
//    
//    // create layer with line
//    let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor(red: 0.4, green: 0.4, blue: 1, alpha: 0.2), lineWidth: 3, animDuration: 0.7, animDelay: 0)
//    let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
//    
//    // view generator - creates circle view for each chartpoint
//    let circleViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
//        return ChartPointCircleView(center: chartPointModel.screenLoc, size: CGSizeMake(20, 20), settings: ChartPointCircleViewSettings(animDuration: 0.5))
//    }
//    // create layer that uses the view generator
//    let chartPointsCircleLayer = ChartPointsViewsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, viewGenerator: circleViewGenerator, displayDelay: 0, delayBetweenItems: 0.05)
//    
//    // create layer with guidelines
//    var settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: ExamplesDefaults.guidelinesWidth, axis: .XAndY)
//    let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
//    
//    let chart = Chart(
//        frame: chartFrame,
//        layers: [
//            xAxis,
//            yAxis,
//            guidelinesLayer,
//            chartPointsLineLayer,
//            chartPointsCircleLayer
//        ]
//    )
    
    //end new implementation 2

    
    view.addSubview(chart.view)
    //self.LineGraphView.frame = CGRectMake(self.LineGraphView.frame.origin.x, self.LineGraphView.frame.origin.y, self.LineGraphView.frame.width, chart.frame.height)
    //print(LineGraphView.frame)
    
    return chart
}