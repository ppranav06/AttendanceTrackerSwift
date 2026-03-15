//
//  AttendanceTrackerApp.swift
//  AttendanceTracker
//
//  Created by Pranav Krishna P on 08/03/26.
//

import SwiftUI

@main
struct AttendanceTrackerApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            // adding persistence controller to ContentView via coredata
            ContentView()
                .environment(
                    \.managedObjectContext,
                     persistenceController.container.viewContext
                )
        }
    }
    
}
