//
//  WorkInProgressDetailedViewController.swift
//  Untitled
//
//  Created by Amadou Camara on 11/10/22.
//

import UIKit
import SwiftUI

class WorkInProgressDetailedViewController: UIViewController {
//    @StateObject var viewModel: HomeViewModel
    let user: User
    
    lazy var bridge: UIViewController = {
        let rootView = WorkInProgressDetailedView() { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        return UIHostingController(rootView: rootView)
    }()
    
    init(user: User) {
//        _viewModel = StateObject(wrappedValue: HomeViewModel(user: user))
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
}
