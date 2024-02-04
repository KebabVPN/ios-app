//
//  kebabApp.swift
//  kebab
//
//  Created by Evgeniy Khashin on 27.12.2023.
//

import SwiftUI

@main
struct kebabApp: App {
    init() {
        Connector.main.initialize()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Connector.main)
        }
    }
}
