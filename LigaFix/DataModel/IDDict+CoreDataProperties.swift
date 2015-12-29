//
//  IDDict+CoreDataProperties.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/25.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension IDDict {

    @NSManaged var cases: NSNumber?
    @NSManaged var records: NSNumber?
    @NSManaged var users: NSNumber?
    @NSManaged var id: NSNumber?

}
