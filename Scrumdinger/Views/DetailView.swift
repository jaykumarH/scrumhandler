//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Jaykumar on 2022-06-14.
//

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    
    var body: some View {
        List {
            Section(
                header: Text("Meeting info"),
                content: {
                    NavigationLink(
                        destination: MeetingView(),
                        label: {
                            Label("Start Meeting", systemImage: "timer")
                                .font(.headline)
                                .foregroundColor(.accentColor)
                        }
                    )
                    HStack {
                        Label("Length", systemImage: "clock")
                        Spacer()
                        Text("\(scrum.lengthInMinutes) minutes")
                    }
                    .accessibilityElement(children: .combine)
                    HStack {
                        Label("Theme", systemImage: "paintpalette")
                        Spacer()
                        Text(scrum.theme.name)
                            .padding(4)
                            .foregroundColor(scrum.theme.accentColor)
                            .background(scrum.theme.mainColor)
                            .cornerRadius(4)
                    }
                    .accessibilityElement(children: .combine)
                }
            )
            
            Section(
                header: Text("Attendees"),
                content: {
                    ForEach(
                        scrum.attendees,
                        id: \.id,
                        content: { attendee in
                            Label(attendee.name, systemImage: "person")
                        }
                    )
                }
            )
            
            Section(
                header: Text("History"),
                content: {
                    Label("No meetings yet", systemImage: "calendar")
                }
            )
        }
        .navigationTitle(scrum.title)
        .toolbar(content: {
            Button(action: {}, label: {
                Text("Edit")
            })
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: DailyScrum.sampleData[0])
        }
    }
}
