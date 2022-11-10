//
//  UntitledApp.swift
//  Untitled
//
//  Created by Amadou Camara on 11/9/22.
//

import SwiftUI

@main
struct UntitledApp: App {
    private var loggedInUser: User {
        var loggedInUser = User(username: "itsdpark")
        // Load works in progress...
        let worksInProgress = [
            WorkInProgress(
                title: "blank looks", creator: loggedInUser,
                dateCreated: Date(), privacy: .openToAll, playlists: [], id: 0),
            WorkInProgress(
                title: "just one cig", creator: loggedInUser,
                dateCreated: Date(), privacy: .openToAll, playlists: [], id: 1),
            WorkInProgress(
                title: "welcome to the way that you look at me", creator: loggedInUser,
                dateCreated: Date(), privacy: .openToAll, playlists: [], id: 2),
            WorkInProgress(
                title: "random melody ideas", creator: loggedInUser,
                dateCreated: Date(), privacy: .openToAll, playlists: [], id: 3)
        ]
        // Set works to
        loggedInUser.worksInProgress = worksInProgress
        // Load
        return loggedInUser
    }
    var body: some Scene {
        WindowGroup {
            // Load user that logged in...
            HomeView(user: loggedInUser)
        }
    }
}
