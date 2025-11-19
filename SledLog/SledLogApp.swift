//
//  SledLogApp.swift
//  SledLog
//
//  Created by Stockton Lott on 11/19/25.
//

import SwiftUI
import CoreData

@main
struct SledLogApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
