//
//  Track.swift
//  Untitled
//
//  Created by Amadou Camara on 11/9/22.
//

import UIKit
import AVFoundation

class Track: ObservableObject, Identifiable {
    let name: String
    let id: Int
    @Published var trackIsPlaying: Bool = false
    let path: String?
    
    lazy var player: AVAudioPlayer? = {
        if let path {
            return try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        }
        return nil
    }()
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
        
        if let path = Bundle.main.path(forResource: name, ofType: "mp3") {
            self.path = path

        } else {
            self.path = nil
        }
    }
    
    func play() {
        if let player = player {
            player.play()
            trackIsPlaying = true
        }
    }
    
    func pause() {
        if let player = player {
            player.pause()
            trackIsPlaying = false
        }
    }
    
    func mute() {
        if let player = player {
            player.setVolume(0, fadeDuration: 0.5)
            trackIsPlaying = false
        }
    }
    
    func unmute() {
        if let player = player {
            player.setVolume(1, fadeDuration: 0.5)
            trackIsPlaying = true
        }
    }
}
