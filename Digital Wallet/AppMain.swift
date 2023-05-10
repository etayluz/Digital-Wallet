//
//  Digital_WalletApp.swift
//  Digital Wallet
//
//  Created by Etay Luz on 4/27/23.
//

import SwiftUI
import AWSDataStorePlugin
import Amplify
import AWSCognitoAuthPlugin
import AWSAPIPlugin
import Authenticator

@main
struct AppMain: App {
    var body: some Scene {
        WindowGroup {
            Authenticator { state in
                Text("Hello, \(state.user.username)")
            }
//            ContentView()
//            LoginView()
        }
    }
    
    // Add a default initializer and configure Amplify
    init() {
        configureAmplify()
    }
    
    func configureAmplify() {
        let apiPlugin = AWSAPIPlugin(modelRegistration: AmplifyModels())
        let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        do {
            try Amplify.add(plugin: apiPlugin)
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.configure()
            print("Initialized Amplify");
        } catch {
            // simplified error handling for the tutorial
            print("Could not initialize Amplify: \(error)")
        }
        
        Task {
            await fetchCurrentAuthSession()
            await signOutLocally()
        }
    }
    
    func fetchCurrentAuthSession() async {
        do {
            let session = try await Amplify.Auth.fetchAuthSession()
            print("Is user signed in - \(session.isSignedIn)")
        } catch let error as AuthError {
            print("Fetch session failed with error \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func signOutLocally() async {
        let result = await Amplify.Auth.signOut()
        guard let signOutResult = result as? AWSCognitoSignOutResult
        else {
            print("Signout failed")
            return
        }

        print("Local signout successful: \(signOutResult.signedOutLocally)")
        switch signOutResult {
        case .complete:
            // Sign Out completed fully and without errors.
            print("Signed out successfully")

        case let .partial(revokeTokenError, globalSignOutError, hostedUIError):
            // Sign Out completed with some errors. User is signed out of the device.
            
            if let hostedUIError = hostedUIError {
                print("HostedUI error  \(String(describing: hostedUIError))")
            }

            if let globalSignOutError = globalSignOutError {
                // Optional: Use escape hatch to retry revocation of globalSignOutError.accessToken.
                print("GlobalSignOut error  \(String(describing: globalSignOutError))")
            }

            if let revokeTokenError = revokeTokenError {
                // Optional: Use escape hatch to retry revocation of revokeTokenError.accessToken.
                print("Revoke token error  \(String(describing: revokeTokenError))")
            }

        case .failed(let error):
            // Sign Out failed with an exception, leaving the user signed in.
            print("SignOut failed with \(error)")
        }
    }
}
