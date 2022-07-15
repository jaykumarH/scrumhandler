//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Jaykumar on 2022-06-11.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var timer = ScrumTimer()
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(
                    secondsElapsed: timer.secondsElapsed,
                    secondsRemaining: timer.secondsRemaining,
                    theme: scrum.theme
                )
                Circle()
                    .strokeBorder(lineWidth: 24)
                MeetingFooterView(
                    speakers: timer.speakers,
                    skipAction: timer.skipSpeaker
                )
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
            timer.reset(
                lengthInMinutes: scrum.lengthInMinutes,
                attendees: scrum.attendees
            )
            timer.startScrum()
            timer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
        }
        .onDisappear {
            timer.stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[1]))
    }
}
