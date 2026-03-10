//
//  Subject.swift
//  AttendanceTracker
//
//  Created by Pranav Krishna P on 09/03/26.
//

import Foundation
import SwiftData

enum Weekday: String, Codable, CaseIterable {
    case monday, tuesday, wednesday, thursday, friday
}

@Model
class Subject {
    var id: UUID
    var name: String
    var days: [Weekday]
    
    init(name: String, days: [Weekday]) {
        self.id = UUID()
        self.name = name
        self.days = days
    }
}
