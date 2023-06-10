//
//  Medication+CoreDataProperties.swift
//  MediBuddy
//
//  Created by Drew Litman on 5/29/23.
//
//

import Foundation
import CoreData


extension Medication {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Medication> {
        return NSFetchRequest<Medication>(entityName: "Medication")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var strength: Float
    @NSManaged public var strengthUnit: String?
    @NSManaged public var type: String?
    @NSManaged public var logEvents: NSSet?
    
    public var logEventsArray: [LogEvent] {
        let set = logEvents as? Set<LogEvent> ?? []
        
        return set.sorted {
            $0.wrappedDate < $1.wrappedDate
        }
    }

}

// MARK: Generated accessors for logEvents
extension Medication {

    @objc(addLogEventsObject:)
    @NSManaged public func addToLogEvents(_ value: LogEvent)

    @objc(removeLogEventsObject:)
    @NSManaged public func removeFromLogEvents(_ value: LogEvent)

    @objc(addLogEvents:)
    @NSManaged public func addToLogEvents(_ values: NSSet)

    @objc(removeLogEvents:)
    @NSManaged public func removeFromLogEvents(_ values: NSSet)

}

extension Medication : Identifiable {

}
