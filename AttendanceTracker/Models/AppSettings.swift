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

    var attendanceThreshold: Double

    init(attendanceThreshold: Double = 75) {
        self.attendanceThreshold = attendanceThreshold
    }
}
