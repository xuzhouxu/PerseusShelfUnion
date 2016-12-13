//
//  TableButton_Red.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/13.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class TableButton_Red: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        showButton()
    }
    
    func showButton() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red:0.90, green:0.25, blue:0.22, alpha:1.0).cgColor
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
