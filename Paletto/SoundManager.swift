//
//  SoundManager.swift
//  HotCocoaPalleto
//
//  Created by LaShelle McClaster  on 12/1/25.
//

import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    
    private var player: AVAudioPlayer?
    
    func playSound(named name: String, fileExtension: String = "mp3") {
        guard let url = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
            print("Sound file \(name).\(fileExtension) not found")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Error playing sound \(name): \(error.localizedDescription)")
        }
    }
}

