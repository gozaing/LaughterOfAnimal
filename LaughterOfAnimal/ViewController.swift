//
//  ViewController.swift
//  LaughterOfAnimal
//
//  Created by tobaru on 2015/07/06.
//  Copyright (c) 2015年 tobaru. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate {
    
    var player : AVAudioPlayer!
    var playButton : UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NSBundleにファイルを配置(SupportFiles)
        let soundFilePath : NSString = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        // ファイルパス
        let fileURL : NSURL = NSURL(fileURLWithPath: soundFilePath as String)!
        
        // AVAudioPlayerのインスタンス生成
        player = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
        
        // AVAudioPlayerのデリゲートセット
        player.delegate = self
        
        // button
        playButton = UIButton()
        playButton.frame.size = CGSizeMake(160, 60)
        playButton.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        playButton.setTitle("music start", forState: UIControlState.Normal)
        playButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        playButton.backgroundColor = UIColor.grayColor()
        playButton.addTarget(self, action: "onClicPlay:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(playButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onClicPlay(sender: UIButton){
        if player.playing == true {
            player.stop()
            sender.setTitle("start", forState: .Normal)
        } else {
            player.play()
            sender.setTitle("stop", forState: .Normal)
        }
    }
}

