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
    var body: some View {
        content
    }
    
    private var content: some View {
        GeometryReader { bounds in
            let safeAreaInsets = bounds.safeAreaInsets
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    Text("Hello, world!")
                        .foregroundColor(.white)

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
                stickyFooter
                    .frame(maxHeight: 60)


            }
        }
        .background(.black)
    }
    
    private var header: some View {
        VStack {
            // Buttons
            HStack {
                // Close
                Button {
                    
                } label: {
                    Image(systemName: "xmark")
                }
                Spacer()
                // Share
                Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            HStack {
                // Information
                VStack(alignment: .leading) {
                    // first line
                    HStack {
                        // title
                        Text("final version")
                        // more info button
                        Button {
                            
                        } label: {
                            Image(systemName: "chevron.down")
                        }
                    }
                    // detail line
                    HStack {
                        Text("itsdpark • 1hr • Only you")
                    }
                    
                }
                Spacer()
                // Download
                Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.down")
                }
            }
            Divider()
        }
        .foregroundColor(.white)
    }
    
    private var stickyFooter: some View {
        VStack {
            Divider()
            // Waveform
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.white)
                .frame(height: 20)
            // Times
            HStack {
                Text("00:00")
                Spacer()
                Text("03:37")
            }
            // Butoons
            HStack {
                // Notes
                Image(systemName: "message.and.waveform")
                    .foregroundColor(.white)
                
                Spacer()
                // Right Buttons
                HStack {
                    // Three buttons
                    HStack {
                        // Back Button
                        Image(systemName: "backward.end")
                            .foregroundColor(.white)
                        Divider()
                        // Stop Button
                        Image(systemName: "stop")
                            .foregroundColor(.white)
                        Divider()
                        // Record button
                        Image(systemName: "circle.fill")
                            .foregroundColor(.red)
                    }
                    // Timer Button
                    Image(systemName: "speedometer")
                        .foregroundColor(.white)
                    //Expand Button
                    Image(systemName: "arrow.left.and.line.vertical.and.arrow.right")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

