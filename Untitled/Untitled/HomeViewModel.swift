//
//  HomeViewModel.swift
//  Untitled
//
//  Created by Amadou Camara on 11/9/22.
//

import UIKit

class HomeViewModel: ObservableObject {    
    let user: User
    
    @Published var currentWorkInProgress: WorkInProgress? {
        didSet {
            if currentWorkInProgress != oldValue {
                currentPlaylistIndex = 0
            }
        }
    }
    
    @Published var currentPlaylistIndex: Int?
    @Published var currentlyAt: String
    @Published var progress: Double
    
    lazy var detailedViewController: WorkInProgressDetailedViewController = {
        return WorkInProgressDetailedViewController(
            user: user,
            workInProgress: currentWorkInProgress!,
            currentPlaylist: currentPlaylist!
        )
    }()

    
    var currentPlaylist: Playlist? {
        guard let currentWorkInProgress = currentWorkInProgress,
              let playlists = currentWorkInProgress.playlists,
                let currentPlaylistIndex = currentPlaylistIndex else { return nil }
        return playlists[currentPlaylistIndex]
    }
    
    var duration: String? {
        guard let tracks = currentPlaylist?.tracks else { return nil }
        
        if let maxDuration = tracks.compactMap({ $0.player?.duration }).max() {
            let duration = Int(maxDuration)
            let seconds = duration % 60
            let minutes = (duration / 60) % 60
            return String(format: "%0.2d:%0.2d", minutes, seconds)
        }
        return "00:00"
    }
    
    var showPlayer: Bool {
        currentWorkInProgress != nil
    }
    
    var worksInProgress: [WorkInProgress]? {
        user.worksInProgress
    }
    
    var notifications: [String] {
        user.notifications
    }
    
    init(user: User) {
        self.user = user
        self.currentlyAt = "00:00"
        self.progress = 0
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
                
                let seconds = Int(currentTime) % 60
                let minutes = (Int(currentTime) / 60) % 60
                currentlyAt = String(format: "%0.2d:%0.2d", minutes, seconds)
            }
        }
    }
    
    func play(workInProgress: WorkInProgress, playlist: Playlist) {
        currentWorkInProgress = workInProgress
        currentWorkInProgress?.isPlaying = true
        playlist.play()
        updateProgress(workInProgress: workInProgress, playlist: playlist)
    }
    
    func pause(workInProgress: WorkInProgress, playlist: Playlist) {
        currentWorkInProgress?.isPlaying = false
        playlist.pause()
    }
    
    
    func openWorkInProgressDetail(with presenter: UIViewController, workInProgress: WorkInProgress, playlist: Playlist) {
        detailedViewController.modalPresentationStyle = .overFullScreen
        presenter.present(detailedViewController, animated: true)
    }
    
    func previousPlaylist() {
        if var currentPlaylistIndex = currentPlaylistIndex {
            currentPlaylistIndex -= 1
        }
    }
    
    func nextPlaylist() {
        if var currentPlaylistIndex = currentPlaylistIndex {
            currentPlaylistIndex += 1
        }
    }
}
