//
//  TileViewStyle.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 7/2/2023.
//

import SwiftUI

struct TileViewStyle: ViewModifier {

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

    enum BorderColor {
        case red
        case blue
        case green

        func makeBorderColor() -> Color {
            switch self {
            case .red:
                return Color.red
            case .blue:
                return Color.blue
            case .green:
                return Color.green
            }
        }
    }

    var title: Title
    var borderColor: BorderColor

    func body(content: Content) -> some View {
        content
            .foregroundColor(title.makeColor())
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(borderColor.makeBorderColor(), lineWidth: 4)
                    .shadow(radius: 5)
            )

    }

}

