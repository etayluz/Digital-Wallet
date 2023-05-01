//
//  ContentView.swift
//  Digital Wallet
//
//  Created by Etay Luz on 4/27/23.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.35).foregroundColor(.white)
                VStack {
                    Text("Login").font(.largeTitle).bold().padding()
                    TextField("Username", text: $username).padding().frame(width:300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red, width: CGFloat(wrongUsername)).textInputAutocapitalization(.never)
                    SecureField("Password", text: $password).padding().frame(width:300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red, width: CGFloat(wrongPassword)).privacySensitive().textInputAutocapitalization(.never)
                    
                    NavigationLink {
                        WelcomeView()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.blue)
                            Text("Login")
                                .foregroundColor(.white)
                        }
                    }.frame(width: 300, height: 50)
                    .padding().disabled(authenticateUser())
        
                }
            }
            .navigationBarHidden(true)
        }
        
    }

    func getLoginBackgroundColor() -> Color {
        if username.count == 0 || password.count == 0 {
            return Color.gray
        }
        else {
            return Color.blue
        }
    }
    
    func authenticateUser() -> Bool {
        return username.count == 0 || password.count == 0
//        return true
//        wrongPassword = 2
//        wrongUsername = 2
//        if username.lowercased().count != 0 {
//            wrongUsername = 0
//            if password.lowercased().count != 0 {
//                wrongPassword = 0
//                showingLoginScreen = true
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
