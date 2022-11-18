//
//  WorkInProgressDetailedView.swift
//  Untitled
//
//  Created by Amadou Camara on 11/9/22.
//

import SwiftUI

private enum Constants {
    static let defaultPadding: CGFloat = 16
    static let cornerRadius: CGFloat = 8
}

struct WorkInProgressDetailedView: View {
    
    let viewModel: WorkInProgressDetailedViewModel
    let dismissAction: () -> Void
    let muteAction: (Track) -> Void
    let unmuteAction: (Track) -> Void
    
    var body: some View {
        content
    }
    
    private var content: some View {
        GeometryReader { bounds in
            let safeAreaInsets = bounds.safeAreaInsets
            if let tracks = viewModel.tracks {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 20) {
                        ForEach(tracks) { track in
                            TrackCardView(track: track, muteAction: muteAction, unmuteAction: unmuteAction)
                        }
                    }
                    .padding(.top, 20)
                    .safeAreaInset(edge: .leading, spacing: 0) {
                        EmptyView().frame(width: safeAreaInsets.leading + Constants.defaultPadding)
                    }
                    .safeAreaInset(edge: .trailing, spacing: 0) {
                        EmptyView().frame(width: safeAreaInsets.trailing + Constants.defaultPadding)
                    }
                    Spacer()
                }
                .safeAreaInset(edge: .top) {
                    VStack {
                        header
                        Divider()
                            .overlay(.white)
                    }
                    .background(Color(red: 39/255, green: 39/255, blue: 39/255))
                }
                .safeAreaInset(edge: .bottom) {
                    stickyFooter
                        .frame(maxHeight: 120)
                        .background(Color(red: 39/255, green: 39/255, blue: 39/255))
                }
            }
            
        }
        .background(Color(red: 39/255, green: 39/255, blue: 39/255))
    }
    
    private var header: some View {
        VStack {
            // Buttons
            HStack {
                // Close
                Button {
                    dismissAction()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                            .fill(Color(red: 58/255, green: 58/255, blue: 58/255))
                            .frame(maxWidth: 60, maxHeight: 25)
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                    }
                }
                Spacer()
                // Share
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                            .fill(Color(red: 58/255, green: 58/255, blue: 58/255))
                            .frame(maxWidth: 60, maxHeight: 25)
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                    }
                }
            }
            .padding(.horizontal, Constants.defaultPadding)
            .padding(.bottom, 20)

            HStack {
                // Information
                VStack(alignment: .leading) {
                    // first line
                    HStack {
                        // title
                        Text(viewModel.workInProgress.title)
                            .font(Font.custom("UntitledSans-Regular", size: 18))
                            .foregroundColor(.white)
                        // more info button
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                                    .fill(Color(red: 58/255, green: 58/255, blue: 58/255))
                                    .frame(maxWidth: 60, maxHeight: 25)
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15, height: 15)
                            }
                        }
                    }
                    // detail line
                    HStack {
                        Text("itsdpark • 1hr • Only you")
                            .font(Font.custom("UntitledSans-Regular", size: 14))
                            .foregroundColor(Color(red: 127/255, green: 127/255, blue: 127/255))

                    }
                    
                }
                Spacer()
                // Download
                Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.down")
                }
            }
            .padding(.bottom, 5)
        }
        .foregroundColor(.white)
        .padding(.horizontal, Constants.defaultPadding)
    }
    
    private var stickyFooter: some View {
        VStack {
            Divider()
                .overlay(.white)
                .padding(.bottom, 3)
                .frame(maxWidth: .infinity)
            
            // Waveform
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.white)
                .frame(height: 20)
                .padding(.horizontal, Constants.defaultPadding)

            Divider()
                .overlay(.white)
                .padding(.vertical, 3)
                .frame(maxWidth: .infinity)

            // Times
            HStack {
                Text("00:00")
                    .font(Font.custom("MajorMonoDisplay-Regular", size: 12))
                    .foregroundColor(Color(red: 188/255, green: 188/255, blue: 188/255))

                Spacer()
                Text("03:37")
                    .font(Font.custom("MajorMonoDisplay-Regular", size: 12))
                    .foregroundColor(Color(red: 188/255, green: 188/255, blue: 188/255))

            }
            .padding(.horizontal, Constants.defaultPadding / 2)
            .padding(.bottom, 6)

            // Butoons
            HStack {
                // Notes
                createSoloButtons(imageName: "message.and.waveform")
                
                Spacer()
                // Right Buttons
                HStack(spacing: 10) {
                    // Three buttons
                    HStack {
                        // Back Button
                        createSoloButtons(imageName: "backward.end")
                        Divider()
                            .overlay(.white)
                            .frame(maxHeight: 40)

                        // Stop Button
                        createSoloButtons(imageName: "stop")
                       
                        Divider()
                            .overlay(.white)
                            .frame(maxHeight: 40)

                        // Record button
                        createSoloButtons(imageName: "circle.fill", color: .red)
                    }
                    .frame(maxHeight: 40)
                    .background(Color(red: 58/255, green: 58/255, blue: 58/255))
                    .cornerRadius(Constants.cornerRadius)

                    // Timer Button
                    createSoloButtons(imageName: "speedometer")
                    //Expand Button
                    createSoloButtons(imageName: "arrow.left.and.line.vertical.and.arrow.right")
                }
            }
            .padding(.horizontal, Constants.defaultPadding)

        }
        .foregroundColor(.white)
    }
    
    func createSoloButtons(imageName: String, color: Color = .white) -> some View{
        return (
            ZStack {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color(red: 58/255, green: 58/255, blue: 58/255))
                    .frame(width: 40, height: 40)
                Image(systemName: "\(imageName)")
                    .foregroundColor(color)
                    .frame(width: 30, height: 30)
            }
        )
        
    }
}

private struct TrackCardView: View {
    @ObservedObject var track: Track
    let muteAction: (Track) -> Void
    let unmuteAction: (Track) -> Void
    
    var body: some View {
        ZStack {
            if track.trackIsPlaying {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color.blue)
            } else {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color(red: 58/255, green: 58/255, blue: 58/255))
            }
            VStack {
                // Top row
                HStack {
                    Text(track.name)
                        .font(Font.custom("UntitledSans-Regular", size: 14))
                        .foregroundColor(.white)
                    Spacer()
                    HStack(spacing: 40) {
                        // mute
                        Button {
                            toggleMuteOf(track: track)
                        } label: {
                            // Change label if track is not muted
                            if track.trackIsPlaying {
                                Image(systemName: "speaker.slash")
                                    .foregroundColor(.white)
                            } else {
                                Image(systemName: "speaker.fill")
                                    .foregroundColor(.white)
                            }
                        }
                        // headphones
                        Button {
                            
                        } label: {
                            Image(systemName: "headphones")
                                .foregroundColor(.white)

                        }
                        
                        // equilizer
                        Button {
                            
                        } label: {
                            Image(systemName: "music.quarternote.3")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal, Constants.defaultPadding)
                .padding(.top, Constants.defaultPadding)

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
        .padding(.bottom, Constants.defaultPadding)
    }
    
    func toggleMuteOf(track: Track) {
        if track.trackIsPlaying {
            muteAction(track)
        } else {
            unmuteAction(track)
        }
    }
}

//struct WorkInProgressDetailedView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkInProgressDetailedView(dismissAction: {})
//    }
//}
