//
//  HomeViewModel.swift
//  Untitled
//
//  Created by Amadou Camara on 11/9/22.
//

import UIKit

class HomeViewModel: ObservableObject {
    let user: User
    
    var worksInProgress: [WorkInProgress]? {
        user.worksInProgress
    }
    
    init(user: User) {
        self.user = user
    }
    
    func openWorkInProgressDetail(with presenter: UIViewController) {
        let detailedViewController = WorkInProgressDetailedViewController(user: user)
        detailedViewController.modalPresentationStyle = .overFullScreen
        presenter.present(detailedViewController, animated: true)
    }
}
