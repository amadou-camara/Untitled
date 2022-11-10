//
//  WorkInProgress.swift
//  Untitled
//
//  Created by Amadou Camara on 11/9/22.
//

import UIKit


struct WorkInProgress: Identifiable {
    
    enum Privacy {
        case openToAll
        case onlyYou
    }
    
    
    let title: String
    let creator: User
    let dateCreated: Date
    let privacy: Privacy
    let playlists: [Playlist]
    var id: Int
//    let coverArt: UIImage?
}
