//
//  ViewController.swift
//  LaughterOfAnimal
//
//  Created by tobaru on 2015/07/06.
//  Copyright (c) 2015年 tobaru. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backFromSecondView(segue:UIStoryboardSegue){
        NSLog("fromEditViewController")
    }
    
}

