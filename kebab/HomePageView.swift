//
//  SwiftUIView.swift
//  JustSomeApp
//
//  Created by jefferson on 30.01.24.
//

import SwiftUI

struct HomePageView: View {
    @State private var isMenuOpen = false
    @State private var menuOffset: CGFloat = -UIScreen.main.bounds.width
    @State private var isLanguageSelectionPresented = false
    
    private let menuWidth: CGFloat = UIScreen.main.bounds.width / 2
    
    var body: some View {
        NavigationView {
            ZStack {
                VPNView()
                    .navigationBarItems(
                        trailing:
                            NavigationLink(
                                destination: MenuView(isLanguageSelectionPresented: $isLanguageSelectionPresented)
                            ) {
                                Image(systemName: "slider.horizontal.3")
                                    .imageScale(.large)
                            }
                    )
            }
        }
    }
}

#Preview {
    HomePageView()
}

