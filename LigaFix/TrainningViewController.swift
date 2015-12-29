//
//  TrainningViewController.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/22.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//

import UIKit

class TrainningViewController: UIViewController {

    @IBOutlet var lblTimeAfterOperation: UILabel!
    @IBOutlet var lblTrainningItem: UILabel!
    @IBOutlet var lblStartTime: UILabel!
    
    @IBOutlet var lblCountTimes: UILabel!
    
    @IBOutlet var btnStartStop: UIButton!
    
    @IBOutlet var progrsCompletionDegree: ASProgressPopUpView!
    
    var isTrainning: Bool! = false
    var countTimes: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 轻按这个按钮，控制开始和暂停；长按结束
    @IBAction func btnActStartStop(sender: UIButton) {
    }

    @IBAction func btnActTrainProject(sender: UIButton) {
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
