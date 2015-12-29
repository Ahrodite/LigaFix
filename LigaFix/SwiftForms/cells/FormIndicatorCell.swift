//
//  FormIndicatorCell.swift
//  LigaFix
//
//  Created by JiaDuan on 15/12/24.
//  Copyright © 2015年 JiaDuan. All rights reserved.
//

import UIKit

public class FormIndicatorCell: FormValueCell {

    /// MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        accessoryType = .DisclosureIndicator
    }
    
    public override func update() {
        super.update()
        titleLabel.text = rowDescriptor.title as String
        if rowDescriptor.subtitle != nil {
            valueLabel.text = rowDescriptor.subtitle! as String
        } else {
            valueLabel.text = nil
        }
    }
    
}
