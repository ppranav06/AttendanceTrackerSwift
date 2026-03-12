//
//  ContentView.swift
//  AttendanceTracker
//
//  Created by Pranav Krishna P on 08/03/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AttendanceDaily()
                .tabItem {
                    Label("Attendance", systemImage: "house.fill")
                }
            SubjectsView()
                .tabItem {
                    Label("Subjects", systemImage: "books.vertical.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Subject.self, AttendanceRecord.self, AppSettings.self], inMemory: false)
}
