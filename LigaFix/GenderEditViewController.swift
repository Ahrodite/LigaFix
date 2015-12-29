//
//  GenderEditViewController.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/27.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//

import UIKit

class GenderEditViewController: FormViewController {
    
    var gender: String? = "男"

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
        self.gender = UserSingleton.sharedInstance.getGender()
    }
    
    private func loadForm() {
        
        let form = FormDescriptor()
        
        form.title = "性别"
        
        // user info section
        let userInfoSection = FormSectionDescriptor()
        
        var row: FormRowDescriptor = FormRowDescriptor(tag: "genderPicker", rowType: .Picker, title: "性别")
        row.configuration[FormRowDescriptor.Configuration.Options] = ["女", "男"]
        row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
            switch( value ) {
            case "女":
                return "女"
            case "男":
                return "男"
            default:
                return nil
            }
        } as TitleFormatterClosure
        row.value = gender == nil ? "男" : gender!
        userInfoSection.addRow(row)
        
        // confirm edit section
        let confirmSection = FormSectionDescriptor()
        
        row = FormRowDescriptor(tag: "confirmGenderEdit", rowType: .Button, title: "确认")
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            let formDict = self.form.formValues()
            let gender = formDict["genderPicker"] as! String
            UserSingleton.sharedInstance.setGender(gender)
            
            self.navigationController?.popViewControllerAnimated(true)
            
            let settingsViewController = self.navigationController?.topViewController as! SettingsViewController
            let indexPath: NSIndexPath = NSIndexPath(forRow: 1, inSection: 0)
            let cell = settingsViewController.tableView.cellForRowAtIndexPath(indexPath) as! FormValueCell
            
            cell.valueLabel.text = gender
            } as DidSelectClosure
        confirmSection.addRow(row)
        
        form.sections = [userInfoSection, confirmSection]
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
