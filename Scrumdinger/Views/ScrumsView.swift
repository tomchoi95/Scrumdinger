//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Tom Choi on 2/14/26.
//

import SwiftUI
import ThemeKit

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresentingNewScrumView: Bool = false
    
    var body: some View {
        NavigationStack{
            List($scrums) { $scrum in
                NavigationLink {
                    DetailView(scrum: $scrum)
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
            
        }
    }
}

#Preview {
    @Previewable @State var scrums = DailyScrum.sampleData
    ScrumsView(scrums: $scrums)
}
