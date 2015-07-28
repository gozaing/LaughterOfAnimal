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
    
    var playButton1 : UIButton!
    var playButton2 : UIButton!

    var player : AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 音声ファイルパス取得 From Supporting Files
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sample1", ofType: "mp3")!)
        
        // プレイヤー準備
        player = AVAudioPlayer(contentsOfURL: audioPath, error: nil)
        
        // AVAudioPlayerのデリゲートセット
        player?.delegate = self

        
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
        
        // 再生終了通知を監視
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "audioStopAction", name: "stop", object: nil)

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
        playSound(sender)
    }
    func onClicPlay2 (sender: UIButton) {
        println("onClickPlay2")
    }
    
    func playSound(sender: UIButton) {
        
        
        println(player.playing)
        
        if player.playing == true {
            player.stop()
            sender.setTitle("start", forState: .Normal)
        } else {
            player.play()
            sender.setTitle("stop", forState: .Normal)
            println("start sound")
            println(player.playing)
        }
    }
    
    // plyaer が再生を終了した際にDelegateから本methodがcallされる
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {

        println("play finish")
        player.stop()

        // 再生終了を通知
        let noti = NSNotification(name: "stop", object: self)
        NSNotificationCenter.defaultCenter().postNotification(noti)
    }
    
    // 再生終了通知検知時処理
    func audioStopAction() {
        // 「Play」表示に戻す
        //btnPlayPause!.setTitle("Play", forState: UIControlState.Normal)
        println("audioStopAction")
        playButton1.setTitle("music start1", forState: UIControlState.Normal)
        
    }
    
    
}

