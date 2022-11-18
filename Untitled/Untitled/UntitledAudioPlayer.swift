//
//  UntitledAudioPlayer.swift
//  Untitled
//
//  Created by Amadou Camara on 11/17/22.
//

import AVFoundation

class UntitledAudioPlayer: NSObject {
    let tracks: [Track]
    var audioPlayers: [AVAudioPlayer] = []
    
    init(tracks: [Track]) {
        self.tracks = tracks
        for track in tracks {
            // replace with url hosted online
            let path = Bundle.main.path(forResource: track.name, ofType: "mp3")!
            let url = URL(fileURLWithPath: path)
            var audioPlayer: AVAudioPlayer
                
            do {
                // Individual player with associated track
                audioPlayer =  try AVAudioPlayer(contentsOf: url)
                audioPlayers.append(audioPlayer)
            } catch {
                // can't load file
                print("\(url) does not exist")
            }
        }
        super.init()
    }
    
    func play() {
        print("playing \(tracks.count) tracks at the same time")
        
        audioPlayers.map { $0.play() }
    }
}
