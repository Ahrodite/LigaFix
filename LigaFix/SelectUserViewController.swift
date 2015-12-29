//
//  SelectUserViewController.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/27.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//

import UIKit

class SelectUserViewController: FormViewController {
    
    var users: NSArray?

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
        users = UserSingleton.sharedInstance.getAllUsers()
    }
    
    private func loadForm() {
        
        let form = FormDescriptor()
        form.title = (users != nil && users!.count > 0) ? "选择用户": "添加用户"
        
        // user info section
        var userListSection: FormSectionDescriptor?
        if users != nil && users!.count > 0 {
            userListSection = FormSectionDescriptor()
            userListSection!.headerTitle = "已有用户"
            
            var no = 0
            for u in users! {
                let user = u as! User
                let username = user.getUsername()
                let row: FormRowDescriptor! = FormRowDescriptor(tag: "userIndicator"+"\(no)", rowType: .Date, title: { (name: String?) -> String in
                    if name != nil {
                        return name!
                    } else {
                        return "No name"
                    }
                    }(username))
                
                row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
                    UserSingleton.sharedInstance.changeActiveStatus()
                    UserSingleton.sharedInstance.user = user
                    UserSingleton.sharedInstance.changeActiveStatus()
                    
                    self.navigationController?.popToRootViewControllerAnimated(true)
                    let settingsViewController = self.navigationController?.topViewController as! SettingsViewController
                    settingsViewController.tabVSettings.reloadData()
                } as DidSelectClosure
                
                userListSection!.addRow(row)
                
                no++
            }
        }
        
        // confirm edit section
        let newUserSection = FormSectionDescriptor()
        
        let row = FormRowDescriptor(tag: "newUserButton", rowType: .Button, title: "新用户")
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            UserSingleton.sharedInstance.changeActiveStatus()
            UserSingleton.sharedInstance.user = nil
            
            self.navigationController?.popToRootViewControllerAnimated(true)
            let settingsViewController = self.navigationController?.topViewController as! SettingsViewController
            settingsViewController.tabVSettings.reloadData()
        } as DidSelectClosure
        newUserSection.addRow(row)
        
        if userListSection != nil {
            form.sections = [userListSection!, newUserSection]
        } else {
            form.sections = [newUserSection]
        }
        
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
