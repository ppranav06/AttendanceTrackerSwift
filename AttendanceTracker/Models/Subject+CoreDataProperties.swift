//
//  Subject+CoreDataProperties.swift
//  AttendanceTracker
//
//  Created by Pranav Krishna P on 15/03/26.
//
//

import Foundation
import CoreData


extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject")
    }

    @NSManaged public var daysRaw: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?

}

extension Subject : Identifiable {

}
