//
//  ControlRatePitchViewController.swift
//  PitchPerfect
//
//  Created by Zedd on 2017. 1. 13..
//  Copyright © 2017년 최송이. All rights reserved.
//

import UIKit
import AVFoundation

class ControlRatePitchViewController: UIViewController {
    
    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var rateSlider: UISlider!
    
    @IBOutlet weak var pitchSlider: UISlider!

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func controlRate(_ sender: Any) {
    }
    @IBOutlet weak var controlPitch: UISlider!

    @IBOutlet weak var stopAudio: UIButton!
    @IBOutlet weak var playAudio: UIButton!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
