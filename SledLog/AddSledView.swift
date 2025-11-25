//
//  AddSledView.swift
//  SledLog
//
//  Created by Stockton Lott on 11/19/25.
//

import SwiftUI

struct AddSledView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var year = ""
    @State private var model = ""
    @State private var notes = ""
    
    var onSave: (Sled) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sled Info")) {
                    TextField("Name", text: $name)
                    TextField("Year", text: $year)
                        .keyboardType(.numberPad)
                    TextField("Model", text: $model)
                    TextField("Notes", text: $notes)
                }
            }
            .navigationTitle("Add Sled")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveSled()
                    }
                    .disabled(name.isEmpty || year.isEmpty || model.isEmpty)
                }
            }
        }
    }
    
    private func saveSled() {
        guard let yearInt = Int(year) else { return }
        
        let newSled = Sled(
            name: name,
            year: yearInt,
            model: model,
            notes: notes
        )
        
        onSave(newSled)
        dismiss()
    }
}

#Preview {
    AddSledView { _ in }
}

