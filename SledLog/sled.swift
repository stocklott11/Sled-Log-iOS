import Foundation

struct Maintenance: Identifiable, Codable, Equatable {
    let id: UUID
    var date: Date
    var type: String
    var notes: String
    var odometer: Int?

    init(id: UUID = UUID(),
         date: Date,
         type: String,
         notes: String = "",
         odometer: Int? = nil) {
        self.id = id
        self.date = date
        self.type = type
        self.notes = notes
        self.odometer = odometer
    }
}

struct Sled: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var year: Int
    var model: String
    var notes: String
    var maintenance: [Maintenance]

    init(id: UUID = UUID(),
         name: String,
         year: Int,
         model: String,
         notes: String = "",
         maintenance: [Maintenance] = []) {
        self.id = id
        self.name = name
        self.year = year
        self.model = model
        self.notes = notes
        self.maintenance = maintenance
    }
}

extension Sled {
    static let sampleData: [Sled] = [
        Sled(
            name: "Patriot 9R",
            year: 2025,
            model: "RMK Khaos 155",
            notes: "New top end, 5 hours on rebuild",
            maintenance: [
                Maintenance(date: Date(), type: "Oil change", notes: "Break-in service", odometer: 5)
            ]
        ),
        Sled(
            name: "850 Boost",
            year: 2024,
            model: "Pro RMK 165",
            notes: "First service done",
            maintenance: [
                Maintenance(date: Date(), type: "Chaincase oil", notes: "Season prep")
            ]
        ),
        Sled(
            name: "Backup sled",
            year: 2018,
            model: "Ski-Doo Summit",
            notes: "Needs clutch service"
        )
    ]
}
