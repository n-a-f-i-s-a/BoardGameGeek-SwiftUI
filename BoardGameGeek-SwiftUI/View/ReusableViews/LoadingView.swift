//
//  LoadingView.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 3/2/2023.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryTitleColor))
                .frame(height: 200)
            Spacer()
        }
    }

}

