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
    
    var playButton1 : UIButton!
    var playButton2 : UIButton!
    var playButton3 : UIButton!
    var playButton4 : UIButton!
    var playButton5 : UIButton!
    var playButton6 : UIButton!
    var playButton7 : UIButton!
    var playButton8 : UIButton!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewSizeWidth = self.view.frame.width/10
        let viewSizeHeight = self.view.frame.height/10
        
        let buttonWidth:CGFloat = 100
        let buttonHeight:CGFloat = 60
        
        // music start button
        playButton1 = UIButton()
        playButton1.frame.size = CGSizeMake(buttonWidth, buttonHeight)
        playButton1.layer.position = CGPoint(x: viewSizeWidth*2, y: viewSizeHeight*8)
        playButton1.setTitle("music start1", forState: UIControlState.Normal)
        playButton1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        playButton1.backgroundColor = UIColor.grayColor()
        playButton1.addTarget(self, action: "onClicPlay1:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(playButton1)
        
        // music start 2 button
        playButton2 = UIButton()
        playButton2.frame.size = CGSizeMake(buttonWidth, buttonHeight)
        playButton2.layer.position = CGPoint(x: viewSizeWidth*6, y: viewSizeHeight*8)
        playButton2.setTitle("music start2", forState: UIControlState.Normal)
        playButton2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        playButton2.backgroundColor = UIColor.grayColor()
        playButton2.addTarget(self, action: "onClicPlay2:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(playButton2)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backFromSecondView(segue:UIStoryboardSegue){
        NSLog("fromEditViewController")
    }
    
    func onClicPlay1 (sender: UIButton) {
        println("onClickPlay1")
    }
    func onClicPlay2 (sender: UIButton) {
        println("onClickPlay2")
    }
    
    
}

