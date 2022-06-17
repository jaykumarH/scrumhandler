//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Jaykumar on 2022-06-11.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
