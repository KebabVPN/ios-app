//
//  MenuView.swift
//  JustSomeApp
//
//  Created by jefferson on 31.01.24.
//

import SwiftUI
import LanguageManagerSwiftUI

struct MenuView: View {
    @Binding var isLanguageSelectionPresented: Bool
    @State var isModalPresented: Bool = false
    @State var tag: Int? = nil
    
    @ObservedObject var loginViewModel: LoginViewModel
    
    init(isLanguageSelectionPresented: Binding<Bool>, loginViewModel: LoginViewModel) {
        self._isLanguageSelectionPresented = isLanguageSelectionPresented
        self.loginViewModel = loginViewModel
    }
    
    var body: some View {
        HStack {
            VStack {
                VStack(alignment: .leading, spacing: 25) {
                    Button(action: { isModalPresented.toggle() }) {
                        Text("Change language")
                            .bold()
                    }
                    .sheet(isPresented: $isModalPresented) {
                        LanguageSelectionView()
                            .frame(
                                minWidth: 350,
                                idealWidth: 500,
                                maxWidth: .infinity,
                                minHeight: 200,
                                idealHeight: 400,
                                maxHeight: .infinity)
                    }
                    
                    Button(action: { }) {
                        Text("Subscription")
                            .bold()
                    }
                    
                    Button(action: { }) {
                        Text("Referrals")
                            .bold()
                    }
                }
                .navigationTitle("Settings")
                .padding()
                
                Spacer()
                ZStack {
                    Button(action: {
                        UserDefaults.standard.removeObject(forKey: "AppleUserId")
                        self.tag = 1
                        loginViewModel.isLoading = false
                    }, label: {
                        Text("Exit")
                            .bold()
                    })
                    .padding()
                }
                .buttonStyle(ExitButtonStyle())
            }
            Spacer()
        }
        Spacer()
    }
    
}

struct LanguageSelectionView: View {
    @EnvironmentObject var languageSettings: LanguageSettings
    
    var body: some View {
        VStack {
            Text("Select a language")
                .frame(height: 50)
            VStack {
                Button("English") {
                    withAnimation {
                        languageSettings.selectedLanguage = .en
                    }
                }
                Button("Russian") {
                    withAnimation {
                        languageSettings.selectedLanguage = .ru
                    }
                }
                Button("Turkish") {
                    withAnimation {
                        languageSettings.selectedLanguage = .tr
                    }
                }
                Button("Chinese") {
                    withAnimation {
                        languageSettings.selectedLanguage = .zhHans
                    }
                }
            }
            .buttonStyle(LanguageButtonStyle())
            Spacer()
        }
    }
}

struct ExitButtonStyle: ButtonStyle {
    @ObservedObject var conn: Connector = Connector.main
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.red)
    }
}

#Preview {
    MenuView(isLanguageSelectionPresented: .constant(false), loginViewModel: LoginViewModel())
}
