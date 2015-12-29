//
//  User.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/24.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    internal func getUsername() -> String? {
        return self.name
    }
    
    internal func changeActiveStatus() {
        if self.isActive == 0 {
            self.isActive = 1
        } else {
            self.isActive = 0
        }
    }
}




