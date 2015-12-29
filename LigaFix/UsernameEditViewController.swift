//
//  UserInfoViewController.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/24.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//

import UIKit
import CoreData

class UsernameEditViewController: FormViewController {
    
    var username: String?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadDate()
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /// MARK: Private interface
    
    private func loadDate() {
        username = UserSingleton.sharedInstance.getActiveUsername()
    }
    
    private func loadForm() {
        
        let form = FormDescriptor()
        
        form.title = "昵称"
        
        // user info section
        let usernameEditSection = FormSectionDescriptor()
        
        var row: FormRowDescriptor! = FormRowDescriptor(tag: "usernameEdit", rowType: .Name, title: "")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = [
            "textField.placeholder" : { (name: String?) -> String in
                if name != nil {
                    return name!
                } else {
                    return "请输入昵称"
                }
            }(username),
            "textField.textAlignment" : NSTextAlignment.Center.rawValue
        ]
        usernameEditSection.addRow(row)
        
        // confirm edit section
        let confirmSection = FormSectionDescriptor()
        row = FormRowDescriptor(tag: "confirmUsernameEdit", rowType: .Button, title: "确认")
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            let formDict = self.form.formValues()
            var newName = formDict["usernameEdit"] as? String
            newName = newName == nil ? self.username : newName
            UserSingleton.sharedInstance.setActiveUsername(newName)
            
            self.navigationController?.popViewControllerAnimated(true)
            
            let settingsViewController = self.navigationController?.topViewController as! SettingsViewController
            let indexPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
            let cell = settingsViewController.tableView.cellForRowAtIndexPath(indexPath) as! FormValueCell
            
            cell.valueLabel.text = newName
        } as DidSelectClosure
        confirmSection.addRow(row)
        
        form.sections = [usernameEditSection, confirmSection]
        self.form = form
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
