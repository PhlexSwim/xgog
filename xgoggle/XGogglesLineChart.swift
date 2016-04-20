//
//  XGogglesLineChart.swift
//  xgoggle
//
//  Created by David Fontenot on 4/19/16.
//  Copyright © 2016 David Fontenot. All rights reserved.
//

import UIKit
import SwiftCharts

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