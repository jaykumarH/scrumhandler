//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Jaykumar on 2022-06-14.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State private var data = DailyScrum.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(
                header: Text("Meeting info"),
                content: {
                    NavigationLink(
                        destination: MeetingView(scrum: $scrum),
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
            Button("Edit") {
                isPresentingEditView = true
                data = scrum.data
            }
        })
        .sheet(
            isPresented: $isPresentingEditView,
            content: {
                NavigationView {
                    DetailEditView(data: $data)
                        .navigationTitle(scrum.title)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingEditView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingEditView = false
                                    scrum.update(from: data)
                                }
                            }
                        }
                }
            }
        )
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}
