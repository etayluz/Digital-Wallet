//
//  LoginView-ViewModel.swift
//  Digital Wallet
//
//  Created by Etay Luz on 5/1/23.
//

import Foundation
import SwiftUI

extension LoginView {
        @MainActor class LoginViewModel: ObservableObject {
        @Published var username = ""
        @Published var password = ""
        @Published var wrongUsername = 0
        @Published var wrongPassword = 0
        
        func buttonTextColor() -> Color {
            if (username.count == 0 || password.count == 0) {
                return Color.white
            }
            
            return Color.white
        }
        
        func buttonBackgroundColor() -> Color {
            if (username.count == 0 || password.count == 0) {
                return Color.gray
            }
            
            return Color.blue
        }
        
        func authenticateUser() -> Bool {
            return username.count == 0 || password.count == 0
        }
    }
}
