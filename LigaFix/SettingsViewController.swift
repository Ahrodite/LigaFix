//
//  SettingsViewController.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/23.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: FormViewController {
    
    
    @IBOutlet var tabVSettings: UITableView!
    
    var username: String?
    var gender: String?
    var age: String?
    var recoveryCaseDateString: String?
    var daysFromOperation: String?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadDate()
        self.loadForm()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.loadDate()
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.loadDate()
        self.loadForm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// MARK: Actions
    
    
    /// MARK: Private interface
    
    private func loadDate() {
        username = UserSingleton.sharedInstance.getActiveUsername()
        gender = UserSingleton.sharedInstance.getGender()
        age = UserSingleton.sharedInstance.getAge()
        recoveryCaseDateString = UserSingleton.sharedInstance.getCurrentCaseDateString()
        daysFromOperation = UserSingleton.sharedInstance.getElapseDaysFromOperation()
    }
    
    private func loadForm() {
        
        let form = FormDescriptor()
        
        form.title = "设置"
        
        // user info section
        let userInfoSection = FormSectionDescriptor()
        userInfoSection.headerTitle = "用户信息"
        
        var row: FormRowDescriptor! = FormRowDescriptor(tag: "usernameIndicator", rowType: .Indicator, title: "昵称", subtitle: username)
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let usernameEditViewController = storyboard.instantiateViewControllerWithIdentifier("UsernameEditViewController")
            self.navigationController?.pushViewController(usernameEditViewController, animated: true)
        } as DidSelectClosure
        userInfoSection.addRow(row)
        
        row = FormRowDescriptor(tag: "genderIndicator", rowType: .Indicator, title: "性别", subtitle: { (gender: String?) -> String in
            if gender != nil {
                return gender!
            } else {
                return ""
            }
        }(gender))
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            let stroyboard = UIStoryboard(name: "Main", bundle: nil)
            let genderEditViewController = stroyboard.instantiateViewControllerWithIdentifier("GenderEditViewController")
            self.navigationController?.pushViewController(genderEditViewController, animated: true)
        } as DidSelectClosure
        userInfoSection.addRow(row)
        
        row = FormRowDescriptor(tag: "ageIndicator", rowType: .Indicator, title: "年龄", subtitle: age)
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let birthdayEditViewController = storyboard.instantiateViewControllerWithIdentifier("BirthdayEditViewController")
            self.navigationController?.pushViewController(birthdayEditViewController, animated: true)
        } as DidSelectClosure
        userInfoSection.addRow(row)
        
        let selectCaseSction = FormSectionDescriptor()
        row = FormRowDescriptor(tag: "selectCaseButton", rowType: .Indicator, title: "手术时间", subtitle: recoveryCaseDateString)
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["titleLabel.textAlignment" : NSTextAlignment.Left.rawValue]
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let selectCaseCtrl = storyboard.instantiateViewControllerWithIdentifier("SelectCaseViewController")
            self.navigationController?.pushViewController(selectCaseCtrl, animated: true)
        } as DidSelectClosure
        selectCaseSction.addRow(row)
        selectCaseSction.footerTitle = daysFromOperation != nil ? "距今" + daysFromOperation! + "天" : ""
        
        // trainning project setting section
        let trainSetSection = FormSectionDescriptor()
        row = FormRowDescriptor(tag: "trainSetButton", rowType: .Button, title: "训练设置")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["titleLabel.textAlignment" : NSTextAlignment.Left.rawValue]
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let trainSetCtrl = storyboard.instantiateViewControllerWithIdentifier("TrainSetViewController")
            self.navigationController?.pushViewController(trainSetCtrl, animated: true)
        } as DidSelectClosure
        trainSetSection.addRow(row)
    
        form.sections = [userInfoSection, selectCaseSction, trainSetSection]
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
