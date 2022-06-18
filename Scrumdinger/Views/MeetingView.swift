//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Jaykumar on 2022-06-11.
//

import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    
    var body: some View {
        ZStack {
            MeetingHeaderView(
                secondsElapsed: 60,
                secondsRemaining: 180,
                theme: scrum.theme
            )
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                Circle()
                    .strokeBorder(lineWidth: 24)
                HStack {
                    Text("Speaker 1 of 3")
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
