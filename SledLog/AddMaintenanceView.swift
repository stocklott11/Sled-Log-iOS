import SwiftUI

struct AddMaintenanceView: View {
    @Environment(\.dismiss) var dismiss

    @State private var date = Date()
    @State private var type = ""
    @State private var notes = ""
    @State private var odometer = ""

    var onSave: (Maintenance) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Maintenance Info")) {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Type (oil change, belt, etc.)", text: $type)
                    TextField("Odometer / hours (optional)", text: $odometer)
                        .keyboardType(.numberPad)
                    TextField("Notes (optional)", text: $notes)
                }
            }
            .navigationTitle("Add Maintenance")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveRecord()
                    }
                    .disabled(type.isEmpty)
                }
            }
        }
    }

    private func saveRecord() {
        let odometerInt = Int(odometer)
        let newRecord = Maintenance(
            date: date,
            type: type,
            notes: notes,
            odometer: odometerInt
        )

        onSave(newRecord)
        dismiss()
    }
}

#Preview {
    AddMaintenanceView { _ in }
}
