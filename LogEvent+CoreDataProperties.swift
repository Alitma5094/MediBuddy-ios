//
//  LogEvent+CoreDataProperties.swift
//  MediBuddy
//
//  Created by Drew Litman on 5/29/23.
//
//

import Foundation
import CoreData


extension LogEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LogEvent> {
        return NSFetchRequest<LogEvent>(entityName: "LogEvent")
    }

    @NSManaged public var date: Date?
    @NSManaged public var amount: Int16
    @NSManaged public var medication: Medication?
    
    public var wrappedDate: Date {
        date ?? Date()
    }

}

extension LogEvent : Identifiable {

}
