//
//  PrimaryText.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 3/2/2023.
//

import Foundation
import SwiftUI

struct StyledText: ViewModifier {

    enum Title {
        case primaryTitle
        case secondaryTitle

        func makeColor() -> Color {
            switch self {
            case .primaryTitle:
                return Color.primaryTitleColor
            case .secondaryTitle:
                return Color.secondaryTitleColor
            }
        }
    }

    enum Alignment {
        case leading
        case center
        case trailing

        func makeAlignment() -> TextAlignment {
            switch self {
            case .leading:
                return TextAlignment.leading
            case .center:
                return TextAlignment.center
            case .trailing:
                return TextAlignment.trailing
            }
        }
    }

    var title: Title
    var alignment: Alignment

    func body(content: Content) -> some View {
        content
            .foregroundColor(title.makeColor())
            .multilineTextAlignment(alignment.makeAlignment())
    }

}

extension View {

    func centeredPrimaryText() -> some View {
        modifier(StyledText(title: .primaryTitle, alignment: .center))
    }

    func centeredSecondaryText() -> some View {
        modifier(StyledText(title: .secondaryTitle, alignment: .leading))
    }

    func leadingPrimaryText() -> some View {
        modifier(StyledText(title: .primaryTitle, alignment: .center))
    }

    func leadingSecondaryText() -> some View {
        modifier(StyledText(title: .secondaryTitle, alignment: .leading))
    }
    
}
