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

    var body: some View {
        content
    }
    
    private var content: some View {
        GeometryReader { bounds in
            let safeAreaInsets = bounds.safeAreaInsets
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
//                    ForEach(homeModel.worksInProgress)
                    WorkInProgressView(
                        workInProgress: WorkInProgress(
                            title: "blank looks", creator: User(username: "itsdpark"),
                            dateCreated: Date(), privacy: .openToAll, playlists: [])
                    )
                    WorkInProgressView(
                        workInProgress: WorkInProgress(
                            title: "just one cig", creator: User(username: "itsdpark"),
                            dateCreated: Date(), privacy: .openToAll, playlists: [])
                    )
                    WorkInProgressView(
                        workInProgress: WorkInProgress(
                            title: "welcome to the way that you look at me", creator: User(username: "itsdpark"),
                            dateCreated: Date(), privacy: .openToAll, playlists: [])
                    )
                    WorkInProgressView(
                        workInProgress: WorkInProgress(
                            title: "random melody ideas", creator: User(username: "itsdpark"),
                            dateCreated: Date(), privacy: .openToAll, playlists: [])
                    )
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
                HStack {
                    VStack {
                        Image(systemName: "textformat")
                        Text("write")
                    }
                    Spacer()
                    Divider()
                        .frame(maxHeight: 60)
                    Spacer()
                    VStack {
                        Image(systemName: "record.circle")
                        Text("record")
                    }
                    Spacer()
                    Divider()
                        .frame(maxHeight: 60)
                    Spacer()
                    VStack {
                        Image(systemName: "waveform")
                        Text("import")
                    }
                }
                .background(Color.white)
                // padding?
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
                ZStack {
                    TextField("Search for anything...", text: $searchBar)
                        .background(Color.gray)
                        .cornerRadius(Constants.defaultPadding)
                        .padding(.horizontal, 8)
                }
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

