//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eggProgress: UIProgressView!
    
    var player: AVAudioPlayer!
    let eggTimes = ["Soft" : 3, "Medium" : 4, "Hard" : 7]
    var timer = Timer()
    var totalTime = 0
    var progressSecond = 0
    @IBAction func keyPressed(_ sender: UIButton) {
        
        timer.invalidate()
        progressSecond = 0
        eggProgress.progress = 0.0
        player?.stop()
        let hardness = sender.currentTitle!
        titleLabel.text = hardness
        
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(downCounter), userInfo: nil, repeats: true)
    }
    @objc func downCounter(){
        if progressSecond <= totalTime {
            eggProgress.progress = Float(progressSecond) / Float(totalTime)
            
            progressSecond += 1
        }else{
            timer.invalidate()
            titleLabel.text = "Done"
            playSound(soundName: "alarm_sound")
        }
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
}
