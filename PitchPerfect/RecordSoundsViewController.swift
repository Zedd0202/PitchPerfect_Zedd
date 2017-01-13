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
        
        //경로를 배열로 편하게 전달 한다.
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)//파일 경로
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate =  self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()//녹음한 준비를 한다.
        audioRecorder.record()//녹음 시작
        
    }
    //stopRecordingButton에 대한 액션
    @IBAction func stopRecording(_ sender: Any) {
        //녹음을 시작하지도 않았는데 활성화가 되어있으면 안되므로 처음에는 사용못하게 설정한다.
        stopRecordingButton.isEnabled = false
        
        //반면에 레코딩 버튼은 사용할 수 있어야한다.
        recordButton.isEnabled = true
        
        //stopButton을 누르면 다시 레코딩을위해 녹음을 하려면 탭을 하라는 메세지를 출력
        recordingLabel.text = "Tab to Record"
        
        //stopButton을 눌렀으므로 녹음을 중지한다.
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    //녹음이 끝나고 수행될 함수
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            //플래그값을 이용해 녹음이 잘 되었으면 performSegue함수를 이용해 다음 뷰로 넘어간다.
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else{
            //false값이 들어오면 녹음이 성공적으로 되지 않았다는 메세지를 출력한다.
            print("recording was not succesful")
        }
    
        
    }
    //만약 identifier가 stopRecording로 들어오면 url을 전달해주기위한 작업을 한다. 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let PlaySoundVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            PlaySoundVC.recordedAudioURL = recordedAudioURL
            
        }
    }
}


