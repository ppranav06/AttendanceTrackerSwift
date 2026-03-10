//
//  AttendanceRecord.swift
//  AttendanceTracker
//
//  Created by Pranav Krishna P on 09/03/26.
//

import Foundation
import SwiftData

@Model
class AttendanceRecord {
    var subject: Subject
    var date: Date
    var isPresent: Bool
    
    init(subject: Subject, date: Date, isPresent: Bool) {
        self.subject = subject
        self.date = date
        self.isPresent = isPresent
    }
}
