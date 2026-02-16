//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Tom Choi on 2/14/26.
//

import SwiftUI
import ThemeKit
import SwiftData

struct ScrumsView: View {
    @Query(sort: \DailyScrum.title) private var scrums: [DailyScrum]
    @State private var isPresentingNewScrumView: Bool = false
    
    var body: some View {
        NavigationStack{
            List(scrums) { scrum in
                NavigationLink {
                    DetailView(scrum: scrum)
                } label: {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button {
                    isPresentingNewScrumView = true
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet()
        }
    }
}

#Preview(traits: .dailyScrumSampleData) {
    ScrumsView()
}
