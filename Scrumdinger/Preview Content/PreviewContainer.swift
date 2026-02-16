//
//  PreviewContainer.swift
//  Scrumdinger
//
//  Created by Tom Choi on 2/16/26.
//

import SwiftData
import SwiftUI

struct DailyScrumSampleData: PreviewModifier {
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try ModelContainer(for: DailyScrum.self, configurations: .init(isStoredInMemoryOnly: true))
        DailyScrum.sampleData.forEach { container.mainContext.insert($0) }
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}


// 이거 하나도 모르겠네
extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var dailyScrumSampleData: Self = .modifier(DailyScrumSampleData())
}
