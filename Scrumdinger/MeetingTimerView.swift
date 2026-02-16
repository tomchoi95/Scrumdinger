//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by Tom Choi on 2/16/26.
//

import SwiftUI
import ThemeKit
import TimerKit

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme
    
    private var currentSpeaker: String {
        speakers.first { !$0.isCompleted }?.name ?? "Someone"
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is Speaking")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
    }
}

#Preview {
    let speakers = [
        ScrumTimer.Speaker(name: "Bill", isCompleted: true),
        ScrumTimer.Speaker(name: "Cathy", isCompleted: false),
    ]
    MeetingTimerView(speakers: speakers, theme: .yellow)
}
