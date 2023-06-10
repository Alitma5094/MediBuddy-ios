//
//  ContentView.swift
//  MediBuddy
//
//  Created by Drew Litman on 5/17/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingAddSheet = false
    @State private var isShowingLogSheet = false
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var medications: FetchedResults<Medication>
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(medications) { medication in
                        NavigationLink {
                            MedicationDetailView(medication: medication)
                        } label: {
                            Text(medication.name ?? "Unknown Name")
                        }
                    }
                }
                HStack {
                    Button("Add Medication") {
                        isShowingAddSheet.toggle()
                    }
                    Button("Take Medications") {
                        isShowingLogSheet.toggle()
                    }
                    Button("Load Data") {
                        let newMed = Medication(context: moc)
                        newMed.id = UUID()
                        newMed.name = "Advil"
                        newMed.type = "Pill"
                        newMed.strength = 0.25
                        newMed.strengthUnit = "mg"
                        try? moc.save()
                        
                        
                        let calendar = Calendar.current
                        let currentDate = Date()
                        let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: currentDate)!
                        var date = oneMonthAgo
                        while date <= currentDate {
                            let randomNumber = Int16.random(in: 1...6)
                            let newLog = LogEvent(context: moc)
                            newLog.date = date
                            newLog.amount = randomNumber
                            newLog.medication = newMed
                            date = calendar.date(byAdding: .day, value: 1, to: date)!
                        }
                        try? moc.save()
                    }
                }
                .sheet(isPresented: $isShowingAddSheet) {
                    AddMedicationView()
                }
                .sheet(isPresented: $isShowingLogSheet) {
                    LogMedicationView()
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
