//
//  SceneDelegate.swift
//  Untitled
//
//  Created by Amadou Camara on 11/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var loggedInUser: User {
        var loggedInUser = User(username: "itsdpark")
        // Load works in progress...
        let worksInProgress = [
            WorkInProgress(
                title: "blank looks", creator: loggedInUser,
                dateCreated: Date(), privacy: .openToAll, playlists: [
                    Playlist(name: "final mix", tracks: [
                        Track(name: "instrumental", id: 1),
                        Track(name: "vocals", id: 2)
                    ])
                ], id: 0),
            WorkInProgress(
                title: "just one cig", creator: loggedInUser,
                dateCreated: Date(), privacy: .openToAll, playlists: [
                    Playlist(name: "v2 mix", tracks: [
                        Track(name: "heatt", id: 1),
                        Track(name: "cig vocals", id: 2)
                    ])
                ], id: 1),
            WorkInProgress(
                title: "welcome to the way that you look at me", creator: loggedInUser,
                dateCreated: Date(), privacy: .openToAll, playlists: [
                    Playlist(name: "v1 mix", tracks: [
                        Track(name: "not your average mix", id: 1),
                        Track(name: "doozy's vocals", id: 2)
                    ])
                ],id: 2),
            WorkInProgress(
                title: "random melody ideas", creator: loggedInUser,
                dateCreated: Date(), privacy: .openToAll, playlists: [
                    Playlist(name: "ideation", tracks: [
                        Track(name: "fun beat", id: 1),
                        Track(name: "sounds", id: 2)
                    ])
                ], id: 3)
        ]
        // Set works to
        loggedInUser.worksInProgress = worksInProgress
        // Load
        return loggedInUser
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = HomeViewController(user: loggedInUser)
        window.makeKeyAndVisible()
        self.window = window
    }
}

