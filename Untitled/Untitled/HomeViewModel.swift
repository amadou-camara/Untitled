//
//  HomeViewModel.swift
//  Untitled
//
//  Created by Amadou Camara on 11/9/22.
//

import Foundation

struct HomeViewModel {
    let user: User
    
    var worksInProgress: [WorkInProgress]? {
        user.worksInProgress
    }
}
