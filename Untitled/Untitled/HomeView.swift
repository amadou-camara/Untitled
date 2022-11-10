//
//  HomeView.swift
//  Untitled
//
//  Created by Amadou Camara on 11/9/22.
//

import SwiftUI

private enum Constants {
    static let defaultPadding: CGFloat = 16
    static let cornerRadius: CGFloat = 8
}

struct HomeView: View {
    @State private var searchBar: String = ""
    
    let user: User
    let viewModel: HomeViewModel
    
    init(user: User) {
        self.user = user
        viewModel = HomeViewModel(user: user)
    }

    var body: some View {
        content
    }
    
    private var content: some View {
        GeometryReader { bounds in
            let safeAreaInsets = bounds.safeAreaInsets
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    if let worksInProgress = viewModel.worksInProgress {
                        ForEach(worksInProgress) { workInProgress in
                            WorkInProgressView(workInProgress: workInProgress)
                            
                        }
                    }
                }
                .safeAreaInset(edge: .leading, spacing: 0) {
                    EmptyView().frame(width: safeAreaInsets.leading + Constants.defaultPadding)
                }
                .safeAreaInset(edge: .trailing, spacing: 0) {
                    EmptyView().frame(width: safeAreaInsets.trailing + Constants.defaultPadding)
                }
                Spacer()
            }
            .safeAreaInset(edge: .top) {
                header
            }
            .safeAreaInset(edge: .bottom) {
                // Update this
                VStack {
                    WorkInProgressPlayerView(workInProgress: viewModel.worksInProgress![0])
                        .padding(.vertical, Constants.defaultPadding)
                        .onTapGesture {
                            print("")
                        }
                    HStack {
                        Button {

                        } label: {
                            VStack {
                                Image(systemName: "textformat")
                                Text("write")
                            }
                        }
                        .padding(.horizontal, 8)


                        Spacer()
                        Divider()
                            .frame(maxHeight: 60)
                        Spacer()
                        Button {

                        } label: {
                            VStack {
                                Image(systemName: "record.circle")
                                Text("record")
                            }
                        }
                        .padding(.horizontal, 8)

                        Spacer()
                        Divider()
                            .frame(maxHeight: 60)
                        Spacer()
                        Button {

                        } label: {
                            VStack {
                                Image(systemName: "waveform")
                                Text("import")
                            }
                        }
                    }
                    .background(Color.white)
                    // padding?
                }
            }
        }
    }
    
    private var header: some View {
        VStack {
            HStack {
                Text("[untitled]")
                Spacer()
                HStack {
                    Image(systemName: "number.circle.fill")
                    Image(systemName: "person.fill")
                }
            }
            HStack {
                // Search bar
                TextField("Search for anything...", text: $searchBar)
                    .background(Color.gray)
                    .cornerRadius(Constants.defaultPadding)
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity)
                    
                Spacer()
                
                // Add button
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                }
                .padding(.horizontal, 8)
            }
        }
        .background(Color.white)
        .frame(maxWidth: .infinity)
    }
}

private struct WorkInProgressView: View {
    let workInProgress: WorkInProgress
    
    var body: some View {
        
        HStack {
            coverArt
                .padding(4)
            textArea
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(Constants.defaultPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .strokeBorder(Color.gray, lineWidth: 1)
        )
    }
    
    private var coverArt: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .frame(width: 60, height: 60)
    }
    
    private var textArea: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(workInProgress.title)
                .lineLimit(1)
                .truncationMode(.tail)
            HStack {
                Text(workInProgress.creator.username)
                // Dot separator + Date + Privacy?
            }
        }
    }
}

private struct WorkInProgressPlayerView: View {
    let workInProgress: WorkInProgress
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.defaultPadding)
                .fill(Color.black)
            VStack {
                // Top
                HStack {
                    // Titie and count
                    VStack {
                        // Title
                        Text("final mix")
                            .foregroundColor(.white)
                        // Count
                        Text("00:23")
                            .foregroundColor(.white)

                    }
                    Spacer()
                    // Notes, Looper, Pause
                    HStack {
                        // Notes
                        Image(systemName: "message.and.waveform")
                            .foregroundColor(.white)

                        // Looper
                        Image(systemName: "repeat.1")
                            .foregroundColor(.white)

                        // Pause
                        Image(systemName: "pause")
                            .foregroundColor(.white)
                    }
                }
                // Waveform view
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color.white)
                    .frame(height: 20)
            }
            .padding(Constants.defaultPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxHeight: 60)

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {

        HomeView(
            user: User(
                username: "itsdpark", worksInProgress: [
                    WorkInProgress(
                        title: "blank looks", creator: User(username: "itsdpark"),
                        dateCreated: Date(), privacy: .openToAll, playlists: [], id: 0
                    ),
                    WorkInProgress(
                        title: "just one cig", creator: User(username: "itsdpark"),
                        dateCreated: Date(), privacy: .openToAll, playlists: [], id: 1
                    ),
                    WorkInProgress(
                        title: "welcome to the way that you look at me", creator: User(username: "itsdpark"),
                        dateCreated: Date(), privacy: .openToAll, playlists: [], id: 2
                    ),
                    WorkInProgress(
                        title: "random melody ideas", creator: User(username: "itsdpark"),
                        dateCreated: Date(), privacy: .openToAll, playlists: [], id: 3
                    )
                ]
            )
        )
    }
}

