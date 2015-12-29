//
//  TrainSetViewController.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/24.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//

import UIKit

class TrainSetViewController: FormViewController {

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
        let userInfoSection = FormSectionDescriptor()
        
        var row: FormRowDescriptor! = FormRowDescriptor(tag: "userInfoButton", rowType: .Button, title: "blabla")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["titleLabel.textAlignment" : NSTextAlignment.Left.rawValue]
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            
            } as DidSelectClosure
        userInfoSection.addRow(row)
        
        form.sections = [userInfoSection]
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
