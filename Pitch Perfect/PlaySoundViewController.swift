//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Mobile Developer on 6/30/15 w [27.5].
//  Copyright (c) 2015 Mobile Developer. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var startTime = 0.0
    var recivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = self.setupAudioPlayerWithFile(recivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func playChipmunkAudio(sender: UIButton) {
        playPitchSound(1000);
    }

    @IBAction func playDarthVaderSound(sender: UIButton) {
        playPitchSound(-1000);
    }

    @IBAction func onSlow(sender: UIButton) {
        playSound(0.5)
    }

    @IBAction func onFast(sender: UIButton) {
        playSound(1.5)
    }

    @IBAction func onStop(sender: UIButton) {
        stopAudio()
    }

    func playSound( newRate: Float){
        stopAudio()
        audioPlayer.currentTime = startTime
        audioPlayer.rate = newRate
        audioPlayer.play()
    }

    func playPitchSound(pitchValue:Float){
        stopAudio()

        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)

        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitchValue
        audioEngine.attachNode(changePitchEffect)

        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)

        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)

        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }

    func setupAudioPlayerWithFile(url: NSURL) -> AVAudioPlayer  {
        var error: NSError?
        var audioPlayer:AVAudioPlayer?
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        return audioPlayer!
    }

   func stopAudio(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
   }
}
