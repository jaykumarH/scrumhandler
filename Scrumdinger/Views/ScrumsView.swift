//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Jaykumar on 2022-06-14.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    
    var body: some View {
        List(
            content: {
                ForEach($scrums, id: \.id) { $scrum in
                    NavigationLink(
                        destination: DetailView(scrum: $scrum),
                        label: {
                            CardView(scrum: scrum)
                        }
                    )
                    .listRowBackground(scrum.theme.mainColor)
                }
            }
        )
        .navigationTitle("Daily Scrum")
        .toolbar(content: {
            Button(action: {}, label: {
                Image(systemName: "plus")
            })
            .accessibilityLabel("New Scrum")
        })
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.sampleData))
        }
    }
}
