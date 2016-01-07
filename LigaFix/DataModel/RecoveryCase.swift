//
//  RecoveryCase.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/24.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//

import Foundation
import CoreData


class RecoveryCase: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    init?(caseID: NSNumber) {
        var cases: NSArray?
        let fetchCase = NSFetchRequest(entityName: "RecoveryCase")
        let casePredicate = NSPredicate(format: "id = %@", caseID)
        fetchCase.predicate = casePredicate
        do {
            cases = try appDelegate.managedObjectContext.executeFetchRequest(fetchCase)
        } catch let error as NSError {
            print("=============error=============")
            print("RecoveryCase(caseID: NSNumber) error")
            print("fetch specific case error")
            print(error.localizedDescription)
        }
        
        let context = appDelegate.managedObjectContext
        super.init(entity: NSEntityDescription.entityForName("RecoveryCase", inManagedObjectContext: context)!, insertIntoManagedObjectContext: context)
        
        if cases != nil && cases?.count > 0 {
            let c = cases![0] as! RecoveryCase
            self.id = c.id
            self.operationDate = c.operationDate
            self.recoveryDate = c.recoveryDate
            self.beginTimeOfDay = c.beginTimeOfDay
            self.endTimeOfDay = c.endTimeOfDay
            self.times = c.times
            self.userID = c.userID
        } else {
            return nil
        }
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    internal func getDateString() -> String? {
        var ret: String?
        if let operationDate = self.operationDate {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy年MM月dd日"
            ret = formatter.stringFromDate(operationDate)
        }
        return ret
    }
}
