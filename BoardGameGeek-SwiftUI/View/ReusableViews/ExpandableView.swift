//
//  ExpandableView.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 8/2/2023.
//

import SwiftUI

struct ExpandableView: View {
    var description: String
    @State var isLearnMoreTapped = false

    var body: some View {
        VStack {
            Text(description)
                .multilineTextAlignment(.center)
                .lineLimit(isLearnMoreTapped ? nil : 2)

            Button(isLearnMoreTapped ? "Learn Less" : "Learn More"){
                isLearnMoreTapped.toggle()

            }
        }

    }
}

struct ExpandableView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableView(description: "Lazy brown fox")
    }
}
