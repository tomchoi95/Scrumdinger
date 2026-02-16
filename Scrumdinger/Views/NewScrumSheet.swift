//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by Tom Choi on 2/15/26.
//

import SwiftUI

struct NewScrumSheet: View {
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: nil)
        }
    }
}

#Preview {
    NewScrumSheet()
}
