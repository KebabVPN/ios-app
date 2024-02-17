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
                LoginScreen()
                .transition(.slide)
                .preferredColorScheme(.dark)
            }
        }
    }
}
