//
//  HomeViewController.swift
//  Untitled
//
//  Created by Amadou Camara on 11/10/22.
//

import UIKit
import SwiftUI

public final class HomeViewController: UIViewController {
    
    @StateObject var viewModel: HomeViewModel
    let user: User
    
    lazy var bridge: UIViewController = {
        let rootView = HomeView(viewModel: viewModel) { [weak self] (workInProgress: WorkInProgress, playlist: Playlist) in
            guard let self = self else { return }
            self.play(workInProgress: workInProgress, playlist: playlist)
        } pauseAction : { [weak self] (workInProgress: WorkInProgress, playlist: Playlist) in
            guard let self = self else { return }
            self.pause(workInProgress: workInProgress, playlist: playlist)
        } openDetailsAction : { [weak self] (workInProgress: WorkInProgress, playlist: Playlist) in
            guard let self = self else { return }
            self.openWorkInProgressDetail(workInProgress: workInProgress, playlist: playlist)
        }
        return UIHostingController(rootView: rootView)
    }()
    
    init(user: User) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(user: user))
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addChild(bridge)
        bridge.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bridge.view.frame = view.bounds
        view.addSubview(bridge.view)
        bridge.didMove(toParent: self)
        
        for family: String in UIFont.familyNames {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
    }
    
    func play(workInProgress: WorkInProgress, playlist: Playlist) {
        viewModel.play(workInProgress: workInProgress, playlist: playlist)
    }
    
    func pause(workInProgress: WorkInProgress, playlist: Playlist) {
        viewModel.pause(workInProgress: workInProgress, playlist: playlist)
    }
    
    func openWorkInProgressDetail(workInProgress: WorkInProgress, playlist: Playlist) {
        viewModel.openWorkInProgressDetail(with: self, workInProgress: workInProgress, playlist: playlist)
    }
}
