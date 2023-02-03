//
//  SecondaryCenteredTextModifier.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 3/2/2023.
//

import Foundation
import SwiftUI

struct CenteredSecondaryText: ViewModifier {

    func body(content: Content) -> some View {
        content
            .foregroundColor(.secondaryTitleColor)
            .multilineTextAlignment(.center)
    }

}

extension View {

    func centeredSecondaryText() -> some View {
        modifier(CenteredSecondaryText())
    }

}

