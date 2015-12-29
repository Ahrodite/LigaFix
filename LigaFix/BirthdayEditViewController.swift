//
//  BirthdayEditViewController.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/27.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//

import UIKit
import CoreData

class BirthdayEditViewController: FormViewController {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadDate()
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    /// MARK: Private interface
    
    private func loadDate() {
        
    }
    
    private func loadForm() {
        
        let form = FormDescriptor()
        
        form.title = "生日"
        
        // user info section
        let userInfoSection = FormSectionDescriptor()
        
        var row: FormRowDescriptor! = FormRowDescriptor(tag: "birthdayPicker", rowType: .Date, title: "生日")
        userInfoSection.addRow(row)
        
        // confirm edit section
        let confirmSection = FormSectionDescriptor()
        
        row = FormRowDescriptor(tag: "confirmBirhtdayEdit", rowType: .Button, title: "确认")
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            let formDict = self.form.formValues()
            let birthday = formDict["birthdayPicker"] as? NSDate
            UserSingleton.sharedInstance.setBirthday(birthday)
            
            self.navigationController?.popViewControllerAnimated(true)
            
            let settingsViewController = self.navigationController?.topViewController as! SettingsViewController
            let indexPath: NSIndexPath = NSIndexPath(forRow: 2, inSection: 0)
            let cell = settingsViewController.tableView.cellForRowAtIndexPath(indexPath) as! FormValueCell
            
            cell.valueLabel.text = UserSingleton.sharedInstance.getAge()
            } as DidSelectClosure
        confirmSection.addRow(row)
        
        form.sections = [userInfoSection, confirmSection]
        self.form = form
    }
}
