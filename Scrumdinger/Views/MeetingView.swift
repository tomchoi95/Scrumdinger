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
import SwiftData

struct MeetingView: View {
    @Environment(\.modelContext) private var context
    let scrum: DailyScrum
    @State var scrumTimer = ScrumTimer()
    @Binding var errorWrapper: ErrorWrapper?
    
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
            startScrum()
        }
        .onDisappear {
            do {
                try endScrum()
            } catch {
                errorWrapper = ErrorWrapper(
                    error: error,
                    guidance: "Meeting time was not recorded. Try again later."
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func startScrum() {
        scrumTimer.reset(
            lengthInMinutes: scrum.lengthInMinutes,
            attendeeNames: scrum.attendees.map(\.name)
        )
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        scrumTimer.startScrum()
    }
    
    private func endScrum() throws {
        scrumTimer.stopScrum()
        let newHistory = History(attendees: scrum.attendees)
        scrum.history.insert(newHistory, at: 0)
        try context.save()
    }
}

#Preview {
    let scrum = DailyScrum.sampleData[0]
    MeetingView(scrum: scrum, errorWrapper: .constant(nil))
}
