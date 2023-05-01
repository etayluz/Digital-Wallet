//
//  WelcomeView.swift
//  Digital Wallet
//
//  Created by Etay Luz on 5/1/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Welcome to IBM DW-KYC").bold().font(.title).padding(.bottom)
            Text("The KYC process consists of 3 simple steps.").padding(.bottom)
            VStack(alignment: .leading, spacing: 15) {
                Text("• Liveliness detection - You will do a series of face gestures to determine whether its a live feed")
                Text("• Upload Documents - You shall upload valid ID documents to use for verification")
                Text("• Validation and summary")
            }.padding(.leading)
        }.navigationBarBackButtonHidden(true)
    }
        
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
