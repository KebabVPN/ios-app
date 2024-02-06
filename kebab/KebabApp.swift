//
//  kebabApp.swift
//  kebab
//
//  Created by Evgeniy Khashin on 27.12.2023.
//

import SwiftUI
import LanguageManagerSwiftUI

@main
struct KebabApp: App {
    var body: some Scene {
        WindowGroup {
            LanguageManagerView(.deviceLanguage) {
                initialView()
                .transition(.slide)
                .preferredColorScheme(.dark)
            }
        }
    }
    
    private func initialView() -> some View {
        if let userId = UserDefaults.standard.string(forKey: "AppleUserId"), !userId.isEmpty {
            return AnyView(HomePageView())
        } else {
            return AnyView(LoginScreen())
        }
    }
}
