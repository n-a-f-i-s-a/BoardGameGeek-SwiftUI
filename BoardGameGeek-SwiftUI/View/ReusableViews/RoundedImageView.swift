//
//  RoundedImageView.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 8/2/2023.
//

import SwiftUI

struct RoundedImageView: View {
    var imageURL: URL?

    var body: some View {
        AsyncImage(url: imageURL)
            .frame(width: 300, height: 300)
            .clipShape(Circle())
            .shadow(radius: 3.0)

    }
}

struct RoundedImageView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedImageView(imageURL: nil)
    }
}
