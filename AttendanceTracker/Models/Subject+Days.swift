//
//  Subject+Days.swift
//  AttendanceTracker
//
//  Created by Pranav Krishna P on 15/03/26.
//

import Foundation

enum Weekday : String, Codable, CaseIterable {
    case monday, tuesday, wednesday, thursday, friday
}

extension Subject {

    var days: [Weekday] {
        get {
            // dataRaw is not an Optional string acc to coredata models, but compiler is being a bitch, idk why
            // it wanted a ? after daysRaw
            guard let data = daysRaw?.data(using: .utf8),
                  let decoded = try? JSONDecoder().decode([Weekday].self, from: data)
            else { return [] }

            return decoded
        }

        set {
            if let data = try? JSONEncoder().encode(newValue) {
                daysRaw = String(data: data, encoding: .utf8) ?? ""
            }
        }
    }
}
