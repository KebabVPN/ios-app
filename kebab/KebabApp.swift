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
//            initialView()
//                .preferredColorScheme(.dark)
            
            LanguageManagerView(.deviceLanguage) {
                initialView() //(isLanguageSelectionPresented: .constant(true))
                .transition(.slide) // The animation that will be happening when the language change.
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
