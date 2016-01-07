//
//  SelectCaseViewController.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/31.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//

import UIKit

class SelectCaseViewController: FormViewController {
    
    var cases: NSArray?

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
        cases = UserSingleton.sharedInstance.getAllCases()
    }
    
    private func loadForm() {
        
        let form = FormDescriptor()
        
        form.title = "选择案例"
        
        // user info section
        var caseListSection: FormSectionDescriptor?
        if cases != nil && cases?.count > 0 {
            caseListSection = FormSectionDescriptor()
            caseListSection!.headerTitle = "已有案例"
            
            var no = 0
            for c in cases! {
                let _case = c as! RecoveryCase
                let operationDateString = _case.getDateString()
                let row: FormRowDescriptor! = FormRowDescriptor(tag: "userIndicator"+"\(no)", rowType: .Indicator, title: operationDateString != nil ? operationDateString! : "")
                
                row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
                    UserSingleton.sharedInstance.setCurrentCase(_case.id)
                    
                    self.navigationController?.popToRootViewControllerAnimated(true)
                    let settingsViewController = self.navigationController?.topViewController as! SettingsViewController
                    settingsViewController.tabVSettings.reloadData()
                } as DidSelectClosure
                
                caseListSection!.addRow(row)
                
                no++
            }
        }
        
        let newCaseSection = FormSectionDescriptor()
        let row = FormRowDescriptor(tag: "newCaseButton", rowType: .Button, title: "新案例")
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newCaseCtrl = storyboard.instantiateViewControllerWithIdentifier("NewCaseViewController")
            self.navigationController?.pushViewController(newCaseCtrl, animated: true)
        } as DidSelectClosure
        newCaseSection.addRow(row)
        
        form.sections = caseListSection != nil ? [caseListSection!, newCaseSection] : [newCaseSection]
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
