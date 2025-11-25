import SwiftUI

struct SledDetailView: View {
    @Binding var sled: Sled

    @State private var showingAddMaintenance = false
    @State private var showingEditSled = false
    @State private var showingEditMaintenance = false
    @State private var editingMaintenanceIndex: Int? = nil

    private func deleteMaintenance(at offsets: IndexSet) {
        sled.maintenance.remove(atOffsets: offsets)
    }

    var body: some View {
        List {

            // MARK: - Blue Header Card
            Section {
                HStack(alignment: .center, spacing: 12) {

                    // Logo placeholder - replace "SledLogLogo" once you add your asset
//                    Image("SledLogLogo")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 56, height: 56)
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                        .shadow(radius: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(sled.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("\(sled.year) \(sled.model)")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))

                        if !sled.notes.isEmpty {
                            Text(sled.notes)
                                .font(.footnote)
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }

                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.blue,
                                    Color.blue.opacity(0.7)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())

            // MARK: - Basic Info Section
            Section(header: Text("Sled Info")) {
                Text("Name: \(sled.name)")
                Text("Year: \(sled.year)")
                Text("Model: \(sled.model)")

                if !sled.notes.isEmpty {
                    Text("Notes: \(sled.notes)")
                }
            }

            // MARK: - Maintenance Section
            Section(header: Text("Maintenance")) {
                if sled.maintenance.isEmpty {
                    Text("No maintenance records yet")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(sled.maintenance) { record in
                        HStack(alignment: .top, spacing: 12) {

                            Image(systemName: "wrench.fill")
                                .font(.title3)
                                .foregroundColor(.blue)
                                .padding(.top, 4)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(record.type)
                                    .font(.headline)

                                Text(record.date.formatted(date: .abbreviated, time: .omitted))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                if let odometer = record.odometer {
                                    Text("Odometer: \(odometer)")
                                        .font(.footnote)
                                }

                                if !record.notes.isEmpty {
                                    Text(record.notes)
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                        .onTapGesture {
                            if let index = sled.maintenance.firstIndex(where: { $0.id == record.id }) {
                                editingMaintenanceIndex = index
                                showingEditMaintenance = true
                            }
                        }
                    }
                    .onDelete(perform: deleteMaintenance)
                }
            }
        }
        .navigationTitle(sled.name)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {

                Button {
                    showingEditSled = true
                } label: {
                    Image(systemName: "pencil")
                }

                Button {
                    showingAddMaintenance = true
                } label: {
                    Image(systemName: "wrench.and.screwdriver")
                }
            }
        }

        // MARK: - Sheets
        .sheet(isPresented: $showingEditSled) {
            EditSledView(sled: $sled)
        }
        .sheet(isPresented: $showingAddMaintenance) {
            AddMaintenanceView { newRecord in
                sled.maintenance.append(newRecord)
            }
        }
        .sheet(isPresented: $showingEditMaintenance) {
            if let index = editingMaintenanceIndex {
                EditMaintenanceView(record: $sled.maintenance[index])
            } else {
                Text("No record selected")
            }
        }
    }
}

#Preview {
    SledDetailView(sled: .constant(Sled.sampleData.first!))
}
