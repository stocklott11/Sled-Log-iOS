import SwiftUI

struct EditSledView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var sled: Sled
    
    @State private var name: String
    @State private var year: String
    @State private var model: String
    @State private var notes: String
    
    init(sled: Binding<Sled>) {
        _sled = sled
        _name = State(initialValue: sled.wrappedValue.name)
        _year = State(initialValue: String(sled.wrappedValue.year))
        _model = State(initialValue: sled.wrappedValue.model)
        _notes = State(initialValue: sled.wrappedValue.notes)
    }
    
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
            .navigationTitle("Edit Sled")
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
                    .disabled(name.isEmpty || year.isEmpty || model.isEmpty)
                }
            }
        }
    }
    
    private func saveChanges() {
        guard let yearInt = Int(year) else { return }
        
        sled.name = name
        sled.year = yearInt
        sled.model = model
        sled.notes = notes
        
        dismiss()
    }
}

#Preview {
    EditSledView(sled: .constant(Sled.sampleData.first!))
}
