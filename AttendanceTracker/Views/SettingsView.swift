//
//  SettingsView.swift
//  AttendanceTracker
//
//  Created by Pranav Krishna P on 12/03/26.
//

import SwiftUI
import Foundation

let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String

// Example usage:

struct SettingsView: View {
    // Persistent storage for settings
    @AppStorage("notificationsEnabled") private var notificationsEnabled : Bool = true
    @AppStorage("attendanceThresholdOverall") private var attendanceThresholdOverall : Double = 75
    @AppStorage("isPerSubjectAttendanceNeeded") private var isPerSubjectAttendanceNeeded : Bool = true
    @AppStorage("attendanceThresholdPerSubject") private var  attendanceThresholdPerSubject : Double  = 75
    
    var body: some View {
        NavigationView {
            Form {
                Section("Attendance") {
                    VStack {
                        HStack {
                            Text("Attendance Threshold")
                            TextField("Percentage", value: $attendanceThresholdOverall, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad) // Suggests a keyboard with a decimal point
                                .padding()
                        }
                        Toggle("Enable Threshold per-Subject", isOn: $isPerSubjectAttendanceNeeded)
                        HStack {
                            Text("Per-Subject Threshold")
                            TextField("Percentage", value: $attendanceThresholdPerSubject, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad) // Suggests a keyboard with a decimal point
                                .padding()
                        }
                            .disabled(isPerSubjectAttendanceNeeded)
                            .foregroundStyle(isPerSubjectAttendanceNeeded ? .primary : .secondary)
                        // foreground to secondary when disabled
                    }
                }
                
                Section("Notifications") {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        if let version = appVersion, let build = buildNumber {
                            Text("\(version) (\(build))")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
        .modelContainer(for: AppSettings.self, inMemory: false)
}
