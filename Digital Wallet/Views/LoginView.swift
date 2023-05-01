//
//  ContentView.swift
//  Digital Wallet
//
//  Created by Etay Luz on 4/27/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.35).foregroundColor(.white)
                VStack {
                    Text("Login").font(.largeTitle).bold().padding()
                    TextField("Username", text: $viewModel.username).padding().frame(width:300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red, width: CGFloat(viewModel.wrongUsername)).textInputAutocapitalization(.never)
                    SecureField("Password", text: $viewModel.password).padding().frame(width:300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red, width: CGFloat(viewModel.wrongPassword)).privacySensitive().textInputAutocapitalization(.never)
                    
                    NavigationLink {
                        WelcomeView()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(viewModel.buttonBackgroundColor())
                            Text("Login")
                                .foregroundColor(viewModel.buttonTextColor())
                        }
                    }.frame(width: 300, height: 50)
                        .padding().disabled(viewModel.authenticateUser())
        
                }
            }
            .navigationBarHidden(true)
        }
        
    }

//    func getLoginBackgroundColor() -> Color {
//        if username.count == 0 || password.count == 0 {
//            return Color.gray
//        }
//        else {
//            return Color.blue
//        }
//    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
