//
//  AddMedicationView.swift
//  MediBuddy
//
//  Created by Drew Litman on 5/17/23.
//

import SwiftUI

struct AddMedicationView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    let types = ["Capsule", "Cream", "Device", "Drops", "Foam", "Gel", "Inhaler", "Injection", "Liquid", "Lotion", "Ointment", "Patch", "Powder", "Tablet", "Suppository", "Topical"]
    let strengthUnits = ["mg", "mcg", "g", "mL", "%"]
    
    @State private var selectedName = "name"
    @State private var selectedType = "Tablet"
    @State private var selectedStrength = 0.0
    @State private var selectedUnit = "mg"
   
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $selectedName)
                    Picker("Type", selection: $selectedType) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                Section {
                    TextField("Strength", value: $selectedStrength, format: .number)
                        .keyboardType(.decimalPad)
                    Picker("Unit", selection: $selectedUnit) {
                        ForEach(strengthUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Strength")
                }
                
                Section {
                    Button("Save") {
                        let newMed = Medication(context: moc)
                        newMed.id = UUID()
                        newMed.name = selectedName
                        newMed.type = selectedType
                        newMed.strength = Float(selectedStrength)
                        newMed.strengthUnit = selectedUnit
                        
                        try? moc.save()
                        dismiss()
                        
                    }
                }
            }
            .navigationTitle("Add Medication")
        }

    }
    
    func saveMed() {
        
    }
}

//struct AddMedicationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddMedicationView()
//    }
//}
