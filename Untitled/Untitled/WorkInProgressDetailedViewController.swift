//
//  WorkInProgressDetailedViewController.swift
//  Untitled
//
//  Created by Amadou Camara on 11/10/22.
//

import UIKit
import SwiftUI

class WorkInProgressDetailedViewController: UIViewController { //, UIViewControllerTransitioningDelegate {
    var viewModel: WorkInProgressDetailedViewModel
    let user: User
    @ObservedObject var homeViewModel: HomeViewModel
//    let presentAnimationController = DetailsViewPresentAnimationController()
//    let dismissAnimationController = DetailsViewDismissAnimationController()
    
    lazy var bridge: UIViewController = {
        let rootView = WorkInProgressDetailedView(viewModel: viewModel, homeViewModel: homeViewModel) { [weak self] in
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
    
    init(user: User, workInProgress: WorkInProgress, currentPlaylist: Playlist, homeViewModel: HomeViewModel) {
        viewModel = WorkInProgressDetailedViewModel(
            user: user,
            workInProgress: workInProgress,
            currentPlaylist: currentPlaylist
        )
        self.homeViewModel = homeViewModel
        self.user = user
        super.init(nibName: nil, bundle: nil)
//        transitioningDelegate = self
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
    
    // Custom animation controllersd
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return presentAnimationController
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return dismissAnimationController
//    }
}
