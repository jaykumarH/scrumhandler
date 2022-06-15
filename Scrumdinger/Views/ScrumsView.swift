//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Jaykumar on 2022-06-14.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    
    var body: some View {
        List(
            content: {
                ForEach(scrums, id: \.id) { scrum in
                    CardView(scrum: scrum)
                        .listRowBackground(scrum.theme.mainColor)
                }
            }
        )
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: DailyScrum.sampleData)
    }
}
