import SwiftUI

struct EditMaintenanceView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var record: Maintenance
    
    @State private var date: Date
    @State private var type: String
    @State private var notes: String
    @State private var odometer: String
    
    init(record: Binding<Maintenance>) {
        _record = record
        _date = State(initialValue: record.wrappedValue.date)
        _type = State(initialValue: record.wrappedValue.type)
        _notes = State(initialValue: record.wrappedValue.notes)
        if let odo = record.wrappedValue.odometer {
            _odometer = State(initialValue: String(odo))
        } else {
            _odometer = State(initialValue: "")
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Maintenance Info")) {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Type", text: $type)
                    TextField("Odometer / hours", text: $odometer)
                        .keyboardType(.numberPad)
                    TextField("Notes", text: $notes)
                }
            }
            .navigationTitle("Edit Maintenance")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveChanges()
                    }
                    .disabled(type.isEmpty)
                }
            }
        }
    }
    
    private func saveChanges() {
        record.date = date
        record.type = type
        record.notes = notes
        record.odometer = Int(odometer)
        
        dismiss()
    }
}

#Preview {
    EditMaintenanceView(record: .constant(
        Maintenance(date: Date(), type: "Oil change", notes: "Preview", odometer: 10)
    ))
}
