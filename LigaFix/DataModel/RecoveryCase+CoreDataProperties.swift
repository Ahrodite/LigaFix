//
//  RecoveryCase+CoreDataProperties.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/31.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension RecoveryCase {

    @NSManaged var beginTimeOfDay: NSDate?
    @NSManaged var endTimeOfDay: NSDate?
    @NSManaged var id: NSNumber?
    @NSManaged var operationDate: NSDate?
    @NSManaged var recoveryDate: NSDate?
    @NSManaged var times: NSNumber?
    @NSManaged var userID: NSNumber?
    @NSManaged var belongToUser: User?
    @NSManaged var hasRecords: NSOrderedSet?

}
