import SwiftUI

struct ContentView: View {
    @State private var sleds: [Sled]
    @State private var showingAddSled = false

    private let storageKey = "sleds"
    private let headerHeight: CGFloat = 220   // taller header so text sits fully in blue

    init() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([Sled].self, from: data) {
            _sleds = State(initialValue: decoded)
        } else {
            _sleds = State(initialValue: Sled.sampleData)
        }
    }

    private func deleteSleds(at offsets: IndexSet) {
        sleds.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                // Background behind everything
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                // List pushed down below the header
                List {
                    Text("Sled Inventory")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                        .padding(.top, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ForEach($sleds) { $sled in
                        NavigationLink(destination: SledDetailView(sled: $sled)) {
                            
                            VStack(alignment: .leading, spacing: 4) {
                                
                                Text(sled.name)
                                    .font(.headline)

                                Text("\(sled.year) \(sled.model)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)

                                if !sled.notes.isEmpty {
                                    Text(sled.notes)
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.vertical, 6)
                        }
                    }
                    .onDelete(perform: deleteSleds)
                }
                .scrollContentBackground(.hidden)
                .padding(.top, headerHeight - 100)   // space for the header

                // Blue header on top
                headerView
            }
            .toolbar {
                Button {
                    showingAddSled = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")   // we draw our own title in the header
            .sheet(isPresented: $showingAddSled) {
                AddSledView { newSled in
                    sleds.append(newSled)
                }
            }
        }
        .onChange(of: sleds) { _, newValue in
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: storageKey)
            }
        }
    }

    // MARK: - Header View

    private var headerView: some View {
        ZStack(alignment: .top) {
            // Blue gradient background
            LinearGradient(
                colors: [Color.blue, Color.blue.opacity(0.75)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(maxWidth: .infinity)
            .frame(height: headerHeight)
            .ignoresSafeArea(edges: .top)

            // Centered text moved up into the blue
            VStack(spacing: 6) {
                Text("Sled Log")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)

                Text("\(sleds.count) sled\(sleds.count == 1 ? "" : "s") tracked")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)

                Text("Tap a sled to view or log maintenance.")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
        }
        .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 6)
    }
}

#Preview {
    ContentView()
}
