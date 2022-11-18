//
//  WorkInProgressDetailedViewModel.swift
//  Untitled
//
//  Created by Amadou Camara on 11/13/22.
//

import UIKit

class WorkInProgressDetailedViewModel: ObservableObject {
    let user: User
    let workInProgress: WorkInProgress
    @Published var currentPlaylist: Playlist
    @Published var tracks: [Track]?
    
    init(user: User, workInProgress: WorkInProgress, currentPlaylist: Playlist) {
        self.user = user
        self.workInProgress = workInProgress
        self.currentPlaylist = currentPlaylist
        if let tracks = currentPlaylist.tracks {
            self.tracks = tracks
        }
    }
    
    // mute and unmute track
    func unmuteTrack(_ track: Track) {
        tracks?.first(where: { $0.id == track.id })?.trackIsPlaying = true
        track.unmute()
    }
    
    func muteTrack(_ track: Track) {
        tracks?.first(where: { $0.id == track.id })?.trackIsPlaying = false
        track.mute()
    }
}
