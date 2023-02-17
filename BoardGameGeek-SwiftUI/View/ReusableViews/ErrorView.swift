//
//  ErrorView.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 3/2/2023.
//

import SwiftUI

struct ErrorView: View {
    var errorText: String

    var body: some View {
        VStack(alignment: .center) {
            Text("We have encountered \(errorText) error!!!")
                .centeredLargeSecondaryText()
        }
    }
    
}
