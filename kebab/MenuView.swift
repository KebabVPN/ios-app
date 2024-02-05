//
//  MenuView.swift
//  JustSomeApp
//
//  Created by jefferson on 31.01.24.
//

import SwiftUI
import AuthenticationServices

struct MenuView: View {
    @Binding var isLanguageSelectionPresented: Bool
    @State var isModalPresented: Bool = false
    
    @State var tag:Int? = nil

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
    private enum Language: String, CaseIterable, Identifiable {
        case eng = "English"
        case rus = "Russian"
        case tur = "Turkish"
        case chi = "Chinese"

        var id: Self { self }
    }
    
    @State private var selectedLanguage: Language = .eng
    
    var body: some View {
        VStack {
            Text("Choose language")
                .frame(height: 50)
            List {
                Picker("Language", selection: $selectedLanguage) {
                    ForEach(Language.allCases) { language in
                        Text(language.rawValue.capitalized)
                    }
                }
            }
        }
    }
}

#Preview {
    MenuView(isLanguageSelectionPresented: .constant(false))
}
