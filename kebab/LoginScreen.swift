//
//  LoginScreen.swift
//  JustSomeApp
//
//  Created by jefferson on 29.01.24.
//

import SwiftUI
import AuthenticationServices
import LanguageManagerSwiftUI

struct LoginScreen: View {
    @ObservedObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        if loginViewModel.isLoading {
            LanguageManagerView(.deviceLanguage) {
                HomePageView(loginViewModel: loginViewModel)
                    .transition(.move(edge: .bottom))
                    .animation(.default)
            }
        } else {
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
                    .disabled(loginViewModel.isSpinning ? true : false)
                }
                
            }
            .padding(30)
            .overlay(
                Group {
                    if loginViewModel.isSpinning {
                        LoaderView()
                    }
                }
            )
            .padding()
            .onAppear {
                if let userId = UserDefaults.standard.string(forKey: "AppleUserId"), !userId.isEmpty {
                    loginViewModel.userIdentifier = userId
                    loginViewModel.isLoading = true
                } else {
                    loginViewModel.userIdentifier = ""
                }
            }
        }
    }
    
}

struct ModalView: View {
    @Binding var isPresented: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                Button("Dismiss",action: {
                    withAnimation(.linear) {
                        isPresented = false
                    }
                })
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
