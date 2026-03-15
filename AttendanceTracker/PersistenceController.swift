//
//  PersistenceController.swift
//  AttendanceTracker
//
//  Created by Pranav Krishna P on 15/03/26.
//

import CoreData

class PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "AttendanceModel")

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed \(error)")
            }
        }
    }
}
