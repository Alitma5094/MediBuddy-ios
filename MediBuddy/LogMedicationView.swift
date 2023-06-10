//
//  LogMedicationView.swift
//  MediBuddy
//
//  Created by Drew Litman on 5/29/23.
//

import SwiftUI

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct LogMedicationView: View {
    @State private var selectedMedications: [Medication] = []
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var medications: FetchedResults<Medication>
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Save") {
                    let currentDate = Date()
                    for medication in selectedMedications {
                        let newLog = LogEvent(context: moc)
                        newLog.medication = medication
                        newLog.date = currentDate
                    }
                    try? moc.save()
                    dismiss()
                }
                List {
                    ForEach(medications, id: \.id) { medication in
                        MultipleSelectionRow(title: medication.name ?? "Unknown Name", isSelected: selectedMedications.contains(medication)) {
                            if selectedMedications.contains(medication) {
                                selectedMedications.removeAll(where: { $0 == medication })
                            }
                            else {
                                selectedMedications.append(medication)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Medications")
        }
    }
}

//struct LogMedicationView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogMedicationView()
//    }
//}
