//
//  UserSingleton.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/25.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//

import Foundation
import CoreData

class UserSingleton {
    class var sharedInstance: UserSingleton {
        struct Static {
            static var instance: UserSingleton = UserSingleton()
        }
        if Static.instance.user == nil {
            Static.instance.user = Static.instance.getActiveUser()
        }
        return Static.instance
    }
    
    var user: User?
    
    internal func getAllUsers() -> NSArray? {
        var users: NSArray?
        let fetchUsers = NSFetchRequest(entityName: "User")
        let userPredicate = NSPredicate(format: "isActive = %@ or isActive = %@", true, false)
        fetchUsers.predicate = userPredicate
        do {
            users = try appDelegate.managedObjectContext.executeFetchRequest(fetchUsers)
        } catch let error as NSError {
            print("=============error=============")
            print("getAllUsers() error")
            print("fetch all users error")
            print(error.localizedDescription)
        }
        return users
    }
    
    private func getActiveUser() -> User {
        var user: User
        
        let fetchActiveUser = NSFetchRequest(entityName: "User")
        let activeUserPredicate = NSPredicate(format: "isActive = %@", true)
        fetchActiveUser.predicate = activeUserPredicate
        var activeUser: NSArray?
        do {
            activeUser = try appDelegate.managedObjectContext.executeFetchRequest(fetchActiveUser)
        } catch let error as NSError {
            print("=============error=============")
            print("getActiveUser() error")
            print("fetch active user error")
            print(error.localizedDescription)
        }
        
        if activeUser != nil && activeUser?.count > 0 {
            user = activeUser![0] as! User
        } else { // 没有活跃用户，插入一个新用户
            user  = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: appDelegate.managedObjectContext) as! User
            user.id = IDDictSingleton.sharedInstance.getUserID()
            user.isActive = true
            user.name = String(user.id!)
            self.saveContext("getActiveUser()")
        }
        
        return user
    }
    
    internal func getNewUser() -> User {
        var user: User
        
        let fetchUnusedUser = NSFetchRequest(entityName: "User")
        let unusedUserPredicate = NSPredicate(format: "name = null")
        fetchUnusedUser.predicate = unusedUserPredicate
        var unusedUsers: NSArray?
        do {
            unusedUsers = try appDelegate.managedObjectContext.executeFetchRequest(fetchUnusedUser)
        } catch let error as NSError {
            print("=============error=============")
            print("getUnusedUser() error")
            print("fetch unused user error")
            print(error.localizedDescription)
        }
        
        if unusedUsers != nil && unusedUsers?.count > 0 {
            user = unusedUsers![0] as! User
            user.isActive = true
        } else { // 没有活跃用户，插入一个新用户
            user  = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: appDelegate.managedObjectContext) as! User
            user.id = IDDictSingleton.sharedInstance.getUserID()
            user.isActive = true
            user.name = String(user.id!)
            self.saveContext("getActiveUser()")
        }
        
        return user
    }
    
    private func saveContext(funcName: String) {
        do {
            try appDelegate.managedObjectContext.save()
        } catch let error as NSError{
            print("=============error=============")
            print(funcName + " error")
            print("context save error")
            print(error.localizedDescription)
        }
    }
    
    // name get & set
    internal func getActiveUsername() -> String? {
        return self.user?.name
    }
    
    internal func setActiveUsername(newName: String?) {
        self.user?.name = newName
        saveContext("setAvtiveUsername(newName: String?)")
    }
    
    // sex get & set
    internal func getGender() -> String? {
        if self.user?.sex != nil {
            if self.user?.sex == 0 {
                return "女"
            } else {
                return "男"
            }
        }
        return nil
    }
    
    internal func setGender(gender: String?) {
        if gender == "女" {
            self.user?.sex = 0
        } else {
            self.user?.sex = 1
        }
        saveContext("setGender(gender: String?)")
    }
    
    // age get & set
    internal func getAge() -> String? {
        let birthday = self.user?.birthday
        var ret: String?
        if birthday != nil {
            let component = NSCalendar.currentCalendar().components(.Year, fromDate: birthday!, toDate: NSDate(), options: NSCalendarOptions.MatchStrictly)
            let age = component.year
            ret = String(age) + "岁"
        }
        return ret
    }
    
    internal func setBirthday(date: NSDate?) {
        self.user?.birthday = date
        saveContext("setBirthday(date: NSDate?)")
    }
    
    internal func getCurrentCase() -> RecoveryCase? {
        var currentCase: RecoveryCase?
        if let currentCaseID = self.user?.currentCaseID {
            var cases: NSArray?
            let fetchCases = NSFetchRequest(entityName: "RecoveryCase")
            let casesPredicate = NSPredicate(format: "userID = %@ and id = %@", self.user!.id!, currentCaseID)
            fetchCases.predicate = casesPredicate
            do {
                cases = try appDelegate.managedObjectContext.executeFetchRequest(fetchCases)
            } catch let error as NSError {
                print("=============error=============")
                print("getCurrentCase() error")
                print("fetch current case error")
                print(error.localizedDescription)
            }
            if cases != nil && cases!.count > 0 {
                currentCase = cases![0] as? RecoveryCase
            }
        }
        
        return currentCase
    }
    
    internal func getCurrentCaseDateString() -> String? {
        var dateString: String?
        let currentCase = self.getCurrentCase()
        if currentCase != nil {
            dateString = currentCase!.getDateString()
        }
        return dateString
    }
    
    internal func getAllCases() -> NSArray? {
        var cases: NSArray?
        let fetchCases = NSFetchRequest(entityName: "RecoveryCase")
        let casesPredicate = NSPredicate(format: "userID = %@", self.user!.id!)
        fetchCases.predicate = casesPredicate
        do {
            cases = try appDelegate.managedObjectContext.executeFetchRequest(fetchCases)
        } catch let error as NSError {
            print("=============error=============")
            print("getAllCases() error")
            print("fetch all cases error")
            print(error.localizedDescription)
        }
        return cases
    }
    
    internal func setCurrentCase(caseID: NSNumber?) {
        if let id = caseID {
            self.user?.currentCaseID = id
        }
    }
    
    internal func getElapseDaysFromOperation() -> String? {
        var elapse: String?
        let currentCase = self.getCurrentCase()
        if let operationDate = currentCase?.operationDate {
            let component = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: operationDate, toDate: NSDate(), options: NSCalendarOptions.MatchStrictly)
            let days = component.day
            elapse = String(days)
        }
        return elapse
    }
    
    internal func addNewCase(date: NSDate?) {
        if let d = date {
            let context = appDelegate.managedObjectContext
            let newCase = RecoveryCase(entity: NSEntityDescription.entityForName("RecoveryCase", inManagedObjectContext: context)!, insertIntoManagedObjectContext: context)
            newCase.id = IDDictSingleton.sharedInstance.getCaseID()
            self.user?.currentCaseID = newCase.id
            newCase.operationDate = d
            newCase.userID = self.user?.id
            newCase.belongToUser = self.user
            saveContext("addNewCase(date: NSDate)")
//            self.user?.hasCasees
        }
    }
    
    // active status change
    internal func changeActiveStatus() {
        self.user!.changeActiveStatus()
        saveContext("changeActiveStatus()")
    }
}








