//
//  IDDictSingleton.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/25.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//

import Foundation
import CoreData

class IDDictSingleton {
    class var sharedInstance: IDDictSingleton {
        struct Static {
            static let instance: IDDictSingleton = IDDictSingleton()
        }
        if Static.instance.idDict == nil {
            Static.instance.initIDDict()
        }
        return Static.instance
    }
    
    var idDict: IDDict?
    
    private func initIDDict() {
        let fetchIDDict = NSFetchRequest(entityName: "IDDict")
        let idDictPredicate = NSPredicate(format: "id = %@", NSNumber(int: 0))
        fetchIDDict.predicate = idDictPredicate
        var idDicts: NSArray?
        do {
            idDicts = try appDelegate.managedObjectContext.executeFetchRequest(fetchIDDict)
        } catch let error as NSError {
            print("=============error=============")
            print("initIDDict() error")
            print("fetch IDDict error")
            print(error.localizedDescription)
        }
        
        if idDicts != nil && idDicts?.count > 0 {
            self.idDict = idDicts![0] as? IDDict
        } else {
            let idDict: IDDict = NSEntityDescription.insertNewObjectForEntityForName("IDDict", inManagedObjectContext: appDelegate.managedObjectContext) as! IDDict
            idDict.id = 0
            idDict.users = 0
            idDict.cases = 0
            idDict.records = 0
//            saveContext("initIDDict()")
            self.idDict = idDict
        }
    }
    
    private func saveContext(funcName: String) {
        do {
            try appDelegate.managedObjectContext.save()
        } catch let error as NSError {
            print("=============error=============")
            print(funcName + " error")
            print("save context error")
            print(error.localizedDescription)
        }
    }
    
    internal func getUserID() -> NSNumber {
        self.idDict?.users = NSNumber(short: (self.idDict?.users!.shortValue)! + 1)
        let ret = self.idDict?.users
//        saveContext("getUserID()")
        return ret!
    }
    
    internal func getCaseID() -> NSNumber {
        self.idDict?.cases = NSNumber(short: (self.idDict?.cases!.shortValue)! + 1)
        let ret = self.idDict?.cases
//        saveContext("getCaseID()")
        return ret!
    }
    
    internal func getRecordID() -> NSNumber {
        self.idDict?.records = NSNumber(int: (self.idDict?.records!.intValue)! + 1)
        let ret = self.idDict?.records
//        saveContext("getRecordID()")
        return ret!
    }
}
