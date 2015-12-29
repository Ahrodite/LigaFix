//
//  TrainningRecord+CoreDataProperties.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/24.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TrainningRecord {

    @NSManaged var caseID: NSNumber?
    @NSManaged var count: NSNumber?
    @NSManaged var id: NSNumber?
    @NSManaged var startDatetime: NSDate?
    @NSManaged var timeLapse: NSNumber?
    @NSManaged var trainType: NSNumber?
    @NSManaged var belongToCase: RecoveryCase?

}
