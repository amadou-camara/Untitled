//
//  WorkInProgressDetailedViewController.swift
//  Untitled
//
//  Created by Amadou Camara on 11/10/22.
//

import UIKit
import SwiftUI

class WorkInProgressDetailedViewController: UIViewController {
    var viewModel: WorkInProgressDetailedViewModel
    let user: User
    
    lazy var bridge: UIViewController = {
        let rootView = WorkInProgressDetailedView(viewModel: viewModel) { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        } muteAction : { [weak self] (track: Track) in
            guard let self = self else { return }
            self.muteTrack(track)
        } unmuteAction : { [weak self] (track: Track) in
            guard let self = self else { return }
            self.unmuteTrack(track)
        }
        
        return UIHostingController(rootView: rootView)
    }()
    
    init(user: User, workInProgress: WorkInProgress, currentPlaylist: Playlist) {
        viewModel = WorkInProgressDetailedViewModel(
            user: user,
            workInProgress: workInProgress,
            currentPlaylist: currentPlaylist
        )
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addChild(bridge)
        bridge.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bridge.view.frame = view.bounds
        view.addSubview(bridge.view)
        bridge.didMove(toParent: self)
    }
    
    func muteTrack(_ track: Track) {
        viewModel.muteTrack(track)
    }
    
    func unmuteTrack(_ track: Track) {
        viewModel.unmuteTrack(track)
    }
}
