//
//  WorkInProgress.swift
//  Untitled
//
//  Created by Amadou Camara on 11/9/22.
//

import UIKit

class WorkInProgress: ObservableObject, Identifiable, Equatable {

    static func == (lhs: WorkInProgress, rhs: WorkInProgress) -> Bool {
        lhs.id == rhs.id
    }
    
    
    enum Privacy {
        case openToAll
        case onlyYou
    }
    
    
    let title: String
    let creator: User
    let dateCreated: Date
    let privacy: Privacy
    let playlists: [Playlist]?
    let coverArt: UIImage?
    var id: Int
    @Published var isPlaying: Bool
    
    init(title: String, creator: User, dateCreated: Date, privacy: Privacy, playlists: [Playlist]? = nil, id: Int, isPlaying: Bool = false) {
        self.title = title
        self.creator = creator
        self.dateCreated = dateCreated
        self.privacy = privacy
        self.playlists = playlists
        self.id = id
        if let filePath = Bundle.main.path(forResource: "cover\(id)", ofType: "jpeg"),
            let image = UIImage(contentsOfFile: filePath) {
            self.coverArt = image
        } else {
            self.coverArt = nil
        }
        self.isPlaying = isPlaying
    }
}
