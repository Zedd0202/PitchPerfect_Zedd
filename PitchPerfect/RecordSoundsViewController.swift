//
//  RecordSoundsViewControllerswift
//  PitchPerfect
//
//  Created by Zedd on 2017. 1. 9..
//  Copyright © 2017년 최송이. All rights reserved.
//

import UIKit
import AVFoundation//오디오 녹음과 오디오효과를 주기 위한 import
import Foundation//소수점 반올림을 위한 import


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder : AVAudioRecorder!

    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //네비게이션 뒤로가기 타이틀은 Record로 만들기 위한 작업
        self.navigationItem.title = "Record"
        
        //처음에 로드되었을 때 stopButton은 recordButton을 누르기 전까지 숨겨져 있어여한다.
        stopRecordingButton.isHidden = true
        
        //레코딩 상태를 텍스트로 나타내주는 라벨도 마찬가지.
        recordingLabel.isHidden = true
//        print("viewDidLoad")

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //record라는 처음 뷰로 돌아갈 때 viewWillAppear는 다시 호출되므로 다시 밑에서  ishidden이 false된 값을 다시 true로 만들어줘야 stopButton과 라벨이 보이지 않는다.
        recordingLabel.isHidden = true
        stopRecordingButton.isHidden = true
//        print("viewWillAppear")

    }
    
    
   //record버튼을 눌렀을 때 할 액션들
    @IBAction func recordAudio(_ sender: Any) {
        
        //숨겨져있던 라벨과 stopButton을 다시 보여지게 한다.
        recordingLabel.isHidden = false
        stopRecordingButton.isHidden = false

        //위에서 라벨이 보여지게 되었으니 레코딩이 진행중이라는 텍스트를 나타내준다.
        recordingLabel.text = "Recording in Progress"
        
        //녹음중일때는 stopButton이 활성화되고 recordButton이 비활성화 되어야함. isEnabled기능을 이용해 구현.
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        
        //디렉토리경로를 지정한다.
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        
        //녹음된파일의 이름을 지정해준다.
        let recordingName = "recordedVoice.wav"
        
        //
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        
        audioRecorder.delegate =  self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }

    @IBAction func stopRecording(_ sender: Any) {
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
        recordingLabel.text = "Tab to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else{
            print("recording was not succesful")
        }
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let PlaySoundVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            PlaySoundVC.recordedAudioURL = recordedAudioURL
            
        }
    }
}


