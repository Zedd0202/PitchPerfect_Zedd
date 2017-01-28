//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Zedd on 2017. 1. 9..
//  Copyright ©ControlRatePitchViewController 2017년 최송이. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import MediaPlayer

class PlaySoundsViewController: UIViewController {

   
    
    
    //접근을하기 위해 필요한 IBoulet변수들
    @IBOutlet weak var volumeControl: UISlider!
    @IBOutlet weak var recordingTime: UILabel!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var buffer: AVAudioPCMBuffer!

    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    var timer : AVAudioPlayer!//duration을 나타내기위해 필요한 변수
    
    var audioPlayer : AVAudioPlayer!
    
    
    var time : TimeInterval = 0.0
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }//버튼타입
    
    //각 버튼을 눌렀을 때 실행할 액션 함수. 소리효과를 가지는 6개의 버튼들은 고유의 태그를 가진다.
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
       //소리를 낸다.
        configureUI(.playing)

        do {
        timer = try AVAudioPlayer(contentsOf: recordedAudioURL as URL)
            //timer.play()

        }
        catch{
            showAlert(Alerts.AudioFileError, message: String(describing: error))
        }
        
        
        //duration을 나타내기 위한 설정이다.
        let time = Int(timer.duration)
        let min = time / 60
        let sec = time % 60
        recordingTime.text = String(format: "녹음시간 : %0.2d 분 : %0.2d 초",min,sec)
       
        
        

    }
    
    //stopButton이 눌리면 재생을 중지한다.
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()

    }
    
    //뷰가 로드될 시 audio를 로드해준다.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
      
        volumeControl.value = UserDefaults.standard.float(forKey: "soundSlider")//저장한 슬라이더 값을 보여준다.


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //뷰가 다 나오고 나면 재생은 되지 않는 상태로 한다. 
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
    @IBAction func adjustVolume(_ sender: UISlider ){
        
        audioPlayerNode?.volume = sender.value
        UserDefaults.standard.set(volumeControl.value, forKey: "soundSlider")//슬라이더 상태 저장

        
    }
}


