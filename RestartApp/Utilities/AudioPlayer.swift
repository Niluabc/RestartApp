//
//  AudioPlayer.swift
//  RestartApp
//
//  Created by Nilam Shah on 09/11/23.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(fileName: String, fileExtension: String) {
    if let path = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Could not play the sound file")
        }
    }
        
}
