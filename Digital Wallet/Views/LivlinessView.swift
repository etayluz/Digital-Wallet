//
//  LivlinessView.swift
//  Digital Wallet
//
//  Created by Etay Luz on 5/1/23.
//

import SwiftUI

struct LivlinessView: View {
    @StateObject private var model = ContentViewModel()
    
    var body: some View {
        ZStack {
          FrameView(image: model.frame)
            .edgesIgnoringSafeArea(.all)

          ErrorView(error: model.error)

          ControlView(
            comicSelected: $model.comicFilter,
            monoSelected: $model.monoFilter,
            crystalSelected: $model.crystalFilter)
        }

    }
}

struct LivlinessView_Previews: PreviewProvider {
    static var previews: some View {
        LivlinessView()
    }
}
