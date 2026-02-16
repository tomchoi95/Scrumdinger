//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by Tom Choi on 2/16/26.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    
    var body: some View {
        VStack {
            Text("An error has occured!")
                .font(.title)
                .padding(.bottom)
            Text(errorWrapper.error.localizedDescription)
                .font(.headline)
            Text(errorWrapper.guidance)
                .font(.caption)
                .padding(.top)
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private enum SampleError: Error {
    case ererorRequired
}

#Preview {
    ErrorView(
        errorWrapper: ErrorWrapper(
            error: SampleError.ererorRequired,
            guidance: "You can safely ignore this error."
        )
    )
}
