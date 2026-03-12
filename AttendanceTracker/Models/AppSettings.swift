//
//  AppSettings.swift
//  AttendanceTracker
//
//  Created by Pranav Krishna P on 09/03/26.
//

import Foundation
import SwiftData

@Model
class AppSettings {

    var attendanceThresholdOverall: Double
    var isPerSubjectAttendanceNeeded : Bool
    var attendanceThresholdPerSubject: Double
    var notificationsEnabled: Bool

    init(attendanceThresholdOverall: Double = 75,
         isPerSubjectAttendanceNeeded: Bool = true,
         attendanceThresholdPerSubject: Double = 75,
         notificationsEnabled: Bool = true) {
        self.attendanceThresholdOverall = attendanceThresholdOverall
        self.isPerSubjectAttendanceNeeded = isPerSubjectAttendanceNeeded
        self.attendanceThresholdPerSubject = attendanceThresholdPerSubject
        self.notificationsEnabled = notificationsEnabled
    }
}
