//
//  Activity+CoreDataProperties.swift
//  
//
//  Created by Johanes Steven on 7/18/19.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var cancellationReason: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var estimatedTime: Int32
    @NSManaged public var isCancelled: Bool
    @NSManaged public var name: String?
    @NSManaged public var spendTime: Int32

}
