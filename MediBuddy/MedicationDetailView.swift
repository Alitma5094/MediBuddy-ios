//
//  MedicationDetailView.swift
//  MediBuddy
//
//  Created by Drew Litman on 5/21/23.
//

import SwiftUI
import Charts

struct MedicationDetailView: View {
    let medication: Medication
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Name: \(medication.name ?? "Unknown")")
                Text("Type: \(medication.type ?? "Unknown")")
                Text("Strength: \(medication.strength) \(medication.strengthUnit ?? "")")
                                ScrollView(.horizontal) {
                                    Chart {
                                        ForEach(medication.logEventsArray) { event in
                                            BarMark(
                                                x: .value("Week Day", event.wrappedDate),
                                                y: .value("Step Count", event.amount),
                                                width: ViewConstants.barWidth
                                            )
                                            .annotation(position: .top) {
                                                Text("\(event.amount)").font(.footnote)
                                            }
                                            .foregroundStyle(ViewConstants.color1)
                                        }
                                    }
                                    .chartYScale(domain: 0...ViewConstants.maxYScale)
                                    .chartYAxis() {
                                        AxisMarks(position: .leading)
                                    }
//                                    .chartXAxis {
//                                        AxisMarks(preset: .extended,
//                                                  position: .bottom,
//                                                  values: .stride (by: .day)) { value in
//                                            if value.as(Date.self)!.isFirstOfMonth() {
//                                                AxisGridLine()
//                                                    .foregroundStyle(.black.opacity(0.5))
//                                                let label = "01\n\(value.as(Date.self)!.monthName())"
//                                                AxisValueLabel(label).foregroundStyle(.black)
//                                            } else {
//                                                AxisValueLabel(
//                                                    format: .dateTime.day(.twoDigits)
//                                                )
//                                            }
//                                        }
//                                    }
                                    .frame(width: ViewConstants.dataPointWidth * CGFloat(medication.logEventsArray.count))
                                }
                        .frame(width: ViewConstants.chartWidth,  height: ViewConstants.chartHeight)
                        
                
                List(medication.logEventsArray) {
                    Text($0.wrappedDate.formatted(date: .complete, time: .shortened))
                }
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
    
private struct ViewConstants {
    static let color1 = Color(hue: 0.33, saturation: 0.81, brightness: 0.76)
    static let minYScale = 5
    static let maxYScale = 12
    static let chartWidth: CGFloat = 350
    static let chartHeight: CGFloat = 400
    static let dataPointWidth: CGFloat = 30
    static let barWidth: MarkDimension = 22
}


//struct MedicationDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicationDetailView()
//    }
//}
