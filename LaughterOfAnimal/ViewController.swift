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
    
    // 再生用
    var player : AVAudioPlayer!
    var playButton : UIButton!
    
    // 録音用
    var recorder: AVAudioRecorder!
    var meterTimer: NSTimer!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var apcLabel: UILabel!
    @IBOutlet weak var peakLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    @IBAction func pushRecord(sender: AnyObject) {
        NSLog("pushRecord Button")
        
        if recorder != nil && recorder.recording {
            self.recorder.pause()
            self.recordButton.setTitle("Continue", forState:.Normal)
        } else {
            self.stopButton.enabled = true
            self.recordButton.setTitle("Pause", forState:.Normal)
            self.recordWithPermission(true)
            
        }

        
    }
    @IBAction func pushStop(sender: AnyObject) {
        NSLog("pushStop Button")
        
        if recorder == nil {
            return
        }
        
        println("stop")
        self.recorder.stop()
        self.meterTimer.invalidate()
        
        self.recordButton.setTitle("Record", forState:.Normal)
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setActive(false, error: &error) {
            println("could not make session inactive")
            if let e = error {
                println(e.localizedDescription)
                return
            }
        }
        self.stopButton.enabled = false
        self.recordButton.enabled = true
        
    }

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
    
    func recordWithPermission(setup:Bool) {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        // ios 8 and later
        if (session.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    println("Permission to record granted")
                    self.setSessionPlayAndRecord()
                    if setup {
                        self.setupRecorder()
                    }
                    self.recorder.record()
                    self.meterTimer = NSTimer.scheduledTimerWithTimeInterval(0.1,
                        target:self,
                        selector:"updateAudioMeter:",
                        userInfo:nil,
                        repeats:true)
                } else {
                    println("Permission to record not granted")
                }
            })
        } else {
            println("requestRecordPermission unrecognized")
        }
    }
    
    func setSessionPlayAndRecord() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setCategory(AVAudioSessionCategoryPlayAndRecord, error:&error) {
            println("could not set session category")
            if let e = error {
                println(e.localizedDescription)
            }
        }
        if !session.setActive(true, error: &error) {
            println("could not make session active")
            if let e = error {
                println(e.localizedDescription)
            }
        }
    }
    
    func setupRecorder() {
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask,true)
        var docsDir: AnyObject = dirPaths[0]
        var soundFilePath = docsDir.stringByAppendingPathComponent("Recorded.m4a")
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        
        var recordSettings = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        
        var error: NSError?
        self.recorder = AVAudioRecorder(URL: soundFileURL!, settings: recordSettings as [NSObject : AnyObject], error: &error)
        if let e = error {
            println(e.localizedDescription)
        } else {
            self.recorder.delegate = self
            self.recorder.meteringEnabled = true
            self.recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
            
        }
    }
    
    func updateAudioMeter(timer:NSTimer) {
        
        if recorder.recording {
            let dFormat = "%02d"
            let min:Int = Int(recorder.currentTime / 60)
            let sec:Int = Int(recorder.currentTime % 60)
            let s = "\(String(format: dFormat, min)):\(String(format: dFormat, sec))"
            statusLabel.text = s
            recorder.updateMeters()
            var apc0 = recorder.averagePowerForChannel(0)
            var peak0 = recorder.peakPowerForChannel(0)
            
            let peak = String(format:"Peak:%@", peak0.description)
            peakLabel.text = peak
            
            let apc = String(format:"Avg:%@", apc0.description)
            apcLabel.text = apc
        }
    }
    
}

extension ViewController : AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!,
        successfully flag: Bool) {
            println("finished recording \(flag)")
            recordButton.setTitle("Record", forState:.Normal)
            
            // iOS8 and later
            var alert = UIAlertController(title: "Recorder",
                message: "Finished Recording",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Keep", style: .Default, handler: {action in
                println("keep was tapped")
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: {action in
                println("delete was tapped")
                self.recorder.deleteRecording()
                self.recorder = nil
                
            }))
            self.presentViewController(alert, animated:true, completion:nil)
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!,
        error: NSError!) {
            println("\(error.localizedDescription)")
    }
}


