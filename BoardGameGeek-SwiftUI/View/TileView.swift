//
//  TileView.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 7/2/2023.
//

import SwiftUI

struct TileView: View {
    var tileInfo: String
    var width: CGFloat
    var height: CGFloat
    var title: TileViewStyle.Title
    var background: TileViewStyle.Background

    var body: some View {
        Text(tileInfo)
            .frame(width: width, height: height)
            .modifier(TileViewStyle(title: title, background: background))
    }

}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(tileInfo: "PlayingTime", width: 100, height: 50, title: .primaryTitle, background: .green)
    }
}
