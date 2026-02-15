//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Tom Choi on 2/14/26.
//

import SwiftUI
import ThemeKit
import TimerKit
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @State var scrumTimer = ScrumTimer()
    
    private let player = AVPlayer.dingPlayer()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(
                    secondsElapsed: scrumTimer.secondsElapsed,
                    secondsRemaining: scrumTimer.secondsRemaining,
                    theme: scrum.theme
                )
                Circle()
                    .strokeBorder(lineWidth: 24)
                MeetingFooterView(
                    speakers: scrumTimer.speakers,
                    skipAction: scrumTimer.skipSpeaker
                )
            }
            .padding()
        }
        .padding()
        .foregroundStyle(scrum.theme.accentColor)
        .onAppear {
            scrumTimer.reset(
                lengthInMinutes: scrum.lengthInMinutes,
                attendeeNames: scrum.attendees.map(\.name)
            )
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
            }
            scrumTimer.startScrum()
        }
        .onDisappear {
            scrumTimer.stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var scrum = DailyScrum.sampleData[0]
    MeetingView(scrum: $scrum)
}
