//
//  NewCaseViewController.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/31.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//

import UIKit

class NewCaseViewController: FormViewController {

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
        
    }
    
    private func loadForm() {
        
        let form = FormDescriptor()
        
        form.title = "设置"
        
        // user info section
        let operationDateSection = FormSectionDescriptor()

        var row: FormRowDescriptor! = FormRowDescriptor(tag: "operationDatePicker", rowType: .Date, title: "手术日期")
        operationDateSection.addRow(row)
        
        // confirm edit section
        let confirmSection = FormSectionDescriptor()
        
        row = FormRowDescriptor(tag: "confirmBirhtdayEdit", rowType: .Button, title: "确认")
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            let formDict = self.form.formValues()
            let operationDate = formDict["operationDatePicker"] as? NSDate
            UserSingleton.sharedInstance.addNewCase(operationDate)
            
            self.navigationController?.popViewControllerAnimated(true)
            
            let settingsViewController = self.navigationController?.topViewController as! SettingsViewController
            let indexPath: NSIndexPath = NSIndexPath(forRow: 2, inSection: 0)
            let cell = settingsViewController.tableView.cellForRowAtIndexPath(indexPath) as! FormValueCell
            
            cell.valueLabel.text = UserSingleton.sharedInstance.getAge()
            } as DidSelectClosure
        confirmSection.addRow(row)
        
        form.sections = [operationDateSection, confirmSection]
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
