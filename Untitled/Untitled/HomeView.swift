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
    static let coverArtSize: CGFloat = 60
}

struct HomeView: View {
    @State private var searchBarText: String = ""
    
    // Gray 1 Color rgba(39, 39, 39, 255) Main background
    // Gray 2 Color rgba(58, 58, 58, 255) Button backgrounds, track off color
    // Gray 3 Color rgba(239, 239, 239, 255)
    // Search bar, Add, profile background Color rgba(243, 243, 243, 255)
    // Primary text color rgba(109, 109, 109, 255)
    let viewModel: HomeViewModel
    let openDetails: () -> Void

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
                footer
            }
        }
    }
    
    private var searchBar: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(red: 243/255, green: 243/255, blue: 243/255))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search for anything...", text: $searchBarText)
            }
            .foregroundColor(Color(red: 109/255, green: 109/255, blue: 109/255))
            .padding(.leading, 10)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .cornerRadius(Constants.cornerRadius)
    }
    
    private var header: some View {
        VStack {
            HStack {
                Text("[untitled]")
                Spacer()
                HStack (spacing: 10) {
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .fill()
                                .foregroundColor(.black)
                            Text("\(viewModel.notifications.count)")
                                .foregroundColor(.white)
                        }
                        .frame(width: 30, height: 30)
                    }
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .fill()
                                .foregroundColor(Color(red: 243/255, green: 243/255, blue: 243/255))
                            Image(systemName: "person.fill")
                                .foregroundColor(.black)
                        }
                        .frame(width: 30, height: 30)
                    }
                }
            }
            HStack (spacing: 10) {
                // Search bar
                searchBar
                    
                Spacer()
                
                // Add button
                ZStack {
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .fill(Color(red: 243/255, green: 243/255, blue: 243/255))
                        .frame(width: 80, height: 40)
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add")
                        }
                    }
                    .foregroundColor(.black)
                }
            }
        }
        .padding(.horizontal, Constants.defaultPadding)
        .padding(.bottom, 5)
        .background(Color.white)
        .frame(maxWidth: .infinity)
    }
    
    private var footer: some View {
        // Update this
        VStack {
            // If something playing animate as slide up from behind HStack
            WorkInProgressPlayerView(workInProgress: viewModel.worksInProgress![0])
                .onTapGesture {
                    openDetails()
                }
            
            VStack {
                Divider()
                HStack {
                    footerButton(image: Image(systemName: "textformat"), text: "write")
                    Divider()
                    footerButton(image: Image(systemName: "circle.fill").foregroundColor(.red)
                                 , text: "record")
                    Divider()
                    footerButton(image: Image(systemName: "waveform"), text: "import")
                }
                .frame(maxWidth: .infinity, maxHeight: 80)
                .background(Color.white)
            }
        }
    }
        
    func footerButton(image: some View, text: String) -> some View {
        return (
            Button {
            
            } label: {
                VStack(spacing: 20) {
                    image
                        .frame(width: 60, height: 60)
                    Text("\(text)")
                }
            }
            .foregroundColor(Color(red: 58/255, green: 58/255, blue: 58/255))
        )
    }
}

private struct WorkInProgressView: View {
    let workInProgress: WorkInProgress
    
    var body: some View {
        
        HStack(){
            coverArt
                .padding(.trailing, 10)
            textArea
                .padding(.trailing, 10)
            Spacer()
            Image(systemName: "chevron.right")
                .padding(.trailing, Constants.defaultPadding)
        }
        .padding(6)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .strokeBorder(Color(red: 58/255, green: 58/255, blue: 58/255), lineWidth: 0.5)
        )
    }
    
    private var coverArt: some View {
        // turn off highlighting on tap
        Button {
            // Play / show player for current playlist
            print("play")
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill()
                    .foregroundColor(.blue)
                    .frame(width: Constants.coverArtSize, height: Constants.coverArtSize)
                ZStack (alignment: .center){
                    // if WIP not playing
                    Circle()
                        .fill()
                        .foregroundColor(Color(red: 0/255, green: 0/255, blue: 0/255, opacity: 0.6))
                        .frame(width: 40, height: 40)

                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .frame(width: 15, height: 15)
                    // if WIP playing
//                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
//                        .fill()
//                        .foregroundColor(Color(red: 0/255, green: 0/255, blue: 0/255, opacity: 0.6))
//                        .frame(width: Constants.coverArtSize, height: Constants.coverArtSize)
//
//                    Image(systemName: "waveform")
//                        .foregroundColor(.white)
//                        .frame(width: 15, height: 15)
                }
            }
        }
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
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color(red: 39/255, green: 39/255, blue: 39/255))
            VStack(spacing: 10) {
                // Top
                HStack {
                    // Titie and count
                    VStack(alignment: .leading) {
                        // Title
                        Text("final mix")
                            .foregroundColor(.white)
                        // Count
                        Text("00:23")
                            .foregroundColor(.white)
                    }
                    Spacer()
                    // Notes, Looper, Pause
                    HStack(spacing: 40) {
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
                .padding(.top, Constants.defaultPadding)
                .padding(.horizontal, Constants.defaultPadding)
                // Waveform view
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color.white)
                    .frame(height: 20)
                    .padding(.horizontal, 4)
                    .padding(.bottom, 4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxHeight: 60)
        .padding(.horizontal, Constants.defaultPadding)
        .padding(.bottom, Constants.defaultPadding)
        .shadow(color: .gray, radius: 3, x: 2, y: 2)

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
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

        return HomeView(viewModel: HomeViewModel(user: loggedInUser)) {}
    }
}

