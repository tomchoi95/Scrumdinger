//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Tom Choi on 2/14/26.
//

import SwiftUI
import SwiftData

@main
struct ScrumdingerApp: App {
    
    var body: some Scene {
        WindowGroup {
            ScrumsView()
        }
        .modelContainer(for: DailyScrum.self)
    }
}
