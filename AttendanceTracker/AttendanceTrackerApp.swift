//
//  AttendanceTrackerApp.swift
//  AttendanceTracker
//
//  Created by Pranav Krishna P on 08/03/26.
//

import SwiftUI
import SwiftData

@main
struct AttendanceTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Subject.self, AttendanceRecord.self, AppSettings.self], inMemory: false)
    }
}
