//
//  LoginScreen.swift
//  JustSomeApp
//
//  Created by jefferson on 29.01.24.
//

import SwiftUI
import AuthenticationServices

struct LoginScreen: View {
    @ObservedObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image("greeting-pic")
                Image("kebab-overlay")
                    .renderingMode(.template)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(spacing: 15) {
                SignInWithAppleButton(
                    onRequest: { request in
                    },
                    onCompletion: { result in
                        switch result {
                        case .success(let authResult):
                            loginViewModel.isLoading = true
                            if let appleIDCredential = authResult.credential as? ASAuthorizationAppleIDCredential {
                                loginViewModel.userId = appleIDCredential.user
                                UserDefaults.standard.setValue(loginViewModel.userId, forKey: "AppleUserId")
                            }
                        case .failure(let error):
                            print("Apple Auth failure: \(error)")
                        }
                    }
                )
                .signInWithAppleButtonStyle(.white)
                .frame(height: 60)
                .cornerRadius(10)
            }
            
        }
        .padding(30)
        .overlay(
            Group {
                if loginViewModel.isLoading {
                    LoaderView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                loginViewModel.isLoading = false
                                loginViewModel.isHomePagePresented = true
                            }
                        }
                }
            }
        )
        .padding()
        .fullScreenCover(isPresented: $loginViewModel.isHomePagePresented) {
            HomePageView()
        }
        .onAppear {
            loginViewModel.userIdentifier = (UserDefaults.standard.value(forKey: "AppleUserId") as? String) ?? ""
        }
    }
    
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
