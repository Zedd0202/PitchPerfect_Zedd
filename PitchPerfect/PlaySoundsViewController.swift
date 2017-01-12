//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Zedd on 2017. 1. 9..
//  Copyright © 2017년 최송이. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
class PlaySoundsViewController: UIViewController {

    
    
   
    @IBOutlet weak var recordingTime: UILabel!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRatePitch: AVAudioUnitTimePitch!
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    var timer : AVAudioPlayer!
    var audioPlayer : AVAudioPlayer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
       
        configureUI(.playing)
        do {
        timer = try AVAudioPlayer(contentsOf: recordedAudioURL as URL)
        }
        catch{
            showAlert(Alerts.AudioFileError, message: String(describing: error))
        }
        let time = Int(timer.duration)
        let min = time / 60
        let sec = time % 60
        recordingTime.text = String(format: "녹음시간 : %0.2d 분 : %0.2d 초",min,sec)
       
        
        

    }
    
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
      

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
   }
