//
//  PrimaryText.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 3/2/2023.
//

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
    var font: Font

    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(title.makeColor())
            .multilineTextAlignment(alignment.makeAlignment())
    }

}

extension View {

    func centeredLargePrimaryText() -> some View {
        modifier(StyledText(title: .primaryTitle, alignment: .center, font: Font.largeTitle))
    }

    func centeredLargeSecondaryText() -> some View {
        modifier(StyledText(title: .secondaryTitle, alignment: .leading, font: Font.largeTitle))
    }

    func centeredSecondaryText() -> some View {
        modifier(StyledText(title: .secondaryTitle, alignment: .leading, font: Font.body))
    }

    func leadingPrimaryText() -> some View {
        modifier(StyledText(title: .primaryTitle, alignment: .center, font: Font.body))
    }

    func leadingSecondaryText() -> some View {
        modifier(StyledText(title: .secondaryTitle, alignment: .leading, font: Font.body))
    }
    
}
