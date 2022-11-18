//
//  Playlist.swift
//  Untitled
//
//  Created by Amadou Camara on 11/9/22.
//

import Foundation

class Playlist {
    let name: String
    var tracks: [Track]?
    
    init(name: String, tracks: [Track]? = nil) {
        self.name = name
        self.tracks = tracks
    }
    
    func play() {
        if let tracks {
            for track in tracks {
                track.play()
            }
        }
    }
    
    func pause() {
        if let tracks {
            for track in tracks {
                track.pause()
            }
        }
    }
}
