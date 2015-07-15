//
//  EditViewController.swift
//  LaughterOfAnimal
//
//  Created by tobaru on 2015/07/13.
//  Copyright (c) 2015年 tobaru. All rights reserved.
//

import Foundation
import UIKit

class EditViewController : UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet var stopButton: UIView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var peakLabel: UILabel!
    @IBOutlet weak var apcLabel: UILabel!
 
    @IBAction func pushRecord(sender: AnyObject) {
        println("push Record")
    }
    @IBAction func pushStop(sender: AnyObject) {
        println("push Stop")
    }
    
    
}