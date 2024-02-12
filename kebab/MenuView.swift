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
                .navigationBarTitleDisplayMode(.large)
                .padding()
                
                Spacer()
                ZStack {
                    NavigationLink(destination: LoginScreen().navigationBarBackButtonHidden(true), tag: 1, selection: $tag) { EmptyView() }
                    Button(action: {
                        UserDefaults.standard.removeObject(forKey: "AppleUserId")
                        self.tag = 1
                    }, label: {
                        Text("Exit")
                            .bold()
                    })
                    .padding()
                    .foregroundColor(.red)
                }
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

#Preview {
    MenuView(isLanguageSelectionPresented: .constant(false))
}
