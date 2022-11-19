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
    
    @Published var progress: Double
    
    var duration: String? {
        guard let tracks else { return nil }
        
        if let maxDuration = tracks.compactMap({ $0.player?.duration }).max() {
            let duration = Int(maxDuration)
            let seconds = duration % 60
            let minutes = (duration / 60) % 60
            return String(format: "%0.2d:%0.2d", minutes, seconds)
        }
        return "00:00"
    }
    
    init(user: User, workInProgress: WorkInProgress, currentPlaylist: Playlist) {
        self.user = user
        self.workInProgress = workInProgress
        self.currentPlaylist = currentPlaylist
        if let tracks = currentPlaylist.tracks {
            self.tracks = tracks
        }
        self.progress = 0
        
        updateProgress(workInProgress: workInProgress, playlist: currentPlaylist)
    }
    
    func updateProgress(workInProgress: WorkInProgress, playlist: Playlist) {
        guard let tracks = playlist.tracks else { return }
        
        // No ! in prod
        let longestTrack = tracks.max(by: { $0.player!.duration > $1.player!.duration })
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] _ in
            if !workInProgress.isPlaying {
                return
            }

            DispatchQueue.main.async { [self] in
                let currentTime = longestTrack!.player!.currentTime
                let longestDuration = longestTrack!.player!.duration
                progress = CGFloat(currentTime / longestDuration)
            }
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
