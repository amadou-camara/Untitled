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
        let rootView = HomeView(viewModel: viewModel) { [weak self] in
            guard let self = self else { return }
            self.openWorkInProgressDetail()
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
    
    func openWorkInProgressDetail() {
        viewModel.openWorkInProgressDetail(with: self)
    }
}
