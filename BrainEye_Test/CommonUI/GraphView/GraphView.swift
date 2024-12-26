//
//  GraphView.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 21/12/2024.
//

import SwiftUI
import Charts

struct GraphView<T: GraphDataRepresentable>: View {
    
    // MARK: - Properties
    private let viewModel: GraphViewModel<T>
    
    // MARK: - Init
    init(viewModel: GraphViewModel<T>) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            makeUnitSymbolHeader()
            Spacer().frame(height: 13)
            makeChart()
            Spacer().frame(height: 26)
            makeRangeLegendView()
        }
        .background(Asset.Colors.backgroundBlack.swiftUIColor)
    }
    
    // MARK: - Chart
    @ViewBuilder
    private func makeChart() -> some View {
        Chart {
            ForEach(viewModel.source) { item in
                makeLineMark(for: item)
                makePointMark(for: item)
            }
            makeRangeArea()
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: .automatic) { value in
                AxisGridLine()
                    .foregroundStyle(.gray)
                AxisValueLabel()
                    .foregroundStyle(.gray)
            }
        }
        .chartXAxis {
            AxisMarks(values: .automatic) { value in
                AxisTick(
                    centered: true,
                    length: 6,
                    stroke: StrokeStyle(lineWidth: 1)
                )
                .foregroundStyle(.gray)
                
                AxisValueLabel {
                    makeAxisXValueLabel(from: value)
                }
                .foregroundStyle(.gray)
                .offset(x: -16, y: 8)
            }
        }
    }
    
    // MARK: - Axis X legend
    private func makeAxisXValueLabel(from value: AxisValue) -> some View {
        guard let date = value.as(Date.self) else { return Text("") }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        let value = formatter.string(from: date)
        return Text(value)
    }
    
    // MARK: - Lines
    private func makeLineMark(for value: T) -> some ChartContent {
        return LineMark(
            x: .value("Date", value.xValue),
            y: .value("Point", value.yValue)
        )
        .foregroundStyle(Asset.Colors.backgroundBlue.swiftUIColor)
        .lineStyle(StrokeStyle(lineWidth: 2.0))
    }
    
    // MARK: - Points
    private func makePointMark(for value: T) -> some ChartContent {
        return PointMark(
            x: .value("Date", value.xValue),
            y: .value("Point", value.yValue)
        )
        .foregroundStyle(Asset.Colors.blueLight.swiftUIColor)
        .symbolSize(6.0)
    }
    
    // MARK: - Range area
    private func makeRangeArea() -> some ChartContent {
        return ForEach(viewModel.source) { point in
            AreaMark(
                x: .value("Date", point.xValue),
                yStart: .value("Min", viewModel.areaRange.lowerBound),
                yEnd: .value("Max", viewModel.areaRange.upperBound)
            )
            .foregroundStyle(
                Asset.Colors.backgroundGray.swiftUIColor.opacity(0.25)
            )
        }
    }
    
    // MARK: - Range legend
    @ViewBuilder
    private func makeRangeLegendView() -> some View {
        HStack {
            Rectangle()
                .fill(Asset.Colors.backgroundGray.swiftUIColor.opacity(0.4))
                .frame(width: 16, height: 16)
            Text(viewModel.areaTitle)
                .font(FontFamily.NunitoSans.regular.swiftUIFont(size: 12))
                .foregroundColor(Asset.Colors.textWhite.swiftUIColor)
        }
    }
    
    // MARK: - Unit legend
    @ViewBuilder
    private func makeUnitSymbolHeader() -> some View {
        Text(viewModel.unitSymbol)
            .font(FontFamily.NunitoSans.regular.swiftUIFont(size: 14))
            .foregroundStyle(Asset.Colors.grayLight.swiftUIColor)
            .padding(.leading, 10)
    }
}
