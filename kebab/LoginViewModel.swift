//
//  LoginViewModel.swift
//  kebab
//
//  Created by jefferson on 4.02.24.
//

import Foundation
import AuthenticationServices

class LoginViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isHomePagePresented = false
    @Published var userId: String = ""
    
    var userIdentifier: String = ""
    let appleIDProvider = ASAuthorizationAppleIDProvider()

    @Published var shouldLogOut = false
    
    init() {
        userIdentifier = (UserDefaults.standard.value(forKey: "AppleUserId") as? String) ?? ""
        NotificationCenter.default.addObserver(self, selector: #selector(appleIDCredentialRevoked(_:)), name: ASAuthorizationAppleIDProvider.credentialRevokedNotification, object: nil)
    }
    
    // ASAuthorizationAppleIDProvider.credentialRevokedNotification handler
    @objc func appleIDCredentialRevoked(_ notification: Notification) {
        print("user id in appleIDCredentialRevoked: \(userIdentifier)")
        appleIDProvider.getCredentialState(forUserID: userIdentifier) { [weak self] (credentialState, error) in
            switch credentialState {
            case .authorized:
                // The Apple ID credential is valid.
                print("appleIDCredentialRevoked: authorized")
                print("The Apple ID credential is valid.")
                break
            case .revoked:
                // The Apple ID credential is revoked. Sign out.
                print("appleIDCredentialRevoked: revoked")
                print("The Apple ID credential is revoked. Sign out.")
                UserDefaults.standard.setValue(nil, forKey: "AppleUserId")
                self?.userIdentifier = ""
                break
            case .notFound:
                // TODO: If no credential was found, show login UI.
                print("No credential was found. Show login UI.")
                break
            case .transferred:
                // TODO:
                // The application was transferred from one development team to another.
                // You can use the same code used to authenticate the user adding the locally saved user identifier in the request.
                print("The application was transferred from one development team to another.")
                print("You can use the same code used to authenticate the user adding the locally saved user identifier in the request.")
            default:
                break
            }
        }
    }
}
