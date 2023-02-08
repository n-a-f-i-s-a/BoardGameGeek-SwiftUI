//
//  TileView.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 7/2/2023.
//

import SwiftUI

struct TileView: View {
    var imageString: String
    var imageTint: Color
    var tileInfo: String
    var width: CGFloat
    var height: CGFloat
    var title: TileViewStyle.Title
    var borderColor: TileViewStyle.BorderColor

    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            Image(systemName: imageString)
                .font(.largeTitle.weight(.semibold))
                .foregroundColor(imageTint)
            Text(tileInfo)
        }
        .frame(width: width, height: height)
        .modifier(TileViewStyle(title: title, borderColor: borderColor))

    }

}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(
            imageString: "star",
            imageTint: .red,
            tileInfo: "PlayingTime",
            width: 100,
            height: 100,
            title: .primaryTitle,
            borderColor: .green
        )
    }
}
