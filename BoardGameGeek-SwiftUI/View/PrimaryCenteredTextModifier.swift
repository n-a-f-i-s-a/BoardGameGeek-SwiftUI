//
//  PrimaryText.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 3/2/2023.
//

import Foundation
import SwiftUI

struct CenteredPrimaryText: ViewModifier {

    func body(content: Content) -> some View {
        content
            .foregroundColor(.primaryTitleColor)
            .multilineTextAlignment(.center)
    }

}

extension View {

    func centeredPrimaryText() -> some View {
        modifier(CenteredPrimaryText())
    }
    
}
