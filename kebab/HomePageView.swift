//
//  SwiftUIView.swift
//  JustSomeApp
//
//  Created by jefferson on 30.01.24.
//

import SwiftUI

struct HomePageView: View {
    @State private var isMenuOpen = false
    @State private var isLanguageSelectionPresented = false
    @ObservedObject var loginViewModel: LoginViewModel
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
    }
    var body: some View {
        NavigationView {
#if os(iOS) || os(tvOS)
            VPNView()
                .toolbar {
                    NavigationLink(
                        destination: MenuView(isLanguageSelectionPresented: $isLanguageSelectionPresented, loginViewModel: loginViewModel)
                    ) {
                        Image(systemName: "slider.horizontal.3")
                            .imageScale(.large)
                    }
                }
#elseif os(macOS)
            MenuView(isLanguageSelectionPresented: $isLanguageSelectionPresented, loginViewModel: loginViewModel)
            VPNView()
#endif
        }
    }
}

#Preview {
    HomePageView(loginViewModel: LoginViewModel())
}

