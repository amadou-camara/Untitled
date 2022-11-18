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
    
    var currentPlaylist: Playlist? {
        guard let currentWorkInProgress = currentWorkInProgress,
              let playlists = currentWorkInProgress.playlists,
                let currentPlaylistIndex = currentPlaylistIndex else { return nil }
        return playlists[currentPlaylistIndex]
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
    }
    
    func play(workInProgress: WorkInProgress, playlist: Playlist) {
        currentWorkInProgress = workInProgress
        currentWorkInProgress?.isPlaying = true
        playlist.play()
    }
    
    func pause(workInProgress: WorkInProgress, playlist: Playlist) {
        currentWorkInProgress?.isPlaying = false
        playlist.pause()
    }
    
    
    func openWorkInProgressDetail(with presenter: UIViewController, workInProgress: WorkInProgress, playlist: Playlist) {
        let detailedViewController = WorkInProgressDetailedViewController(user: user, workInProgress: workInProgress, currentPlaylist: playlist)
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
