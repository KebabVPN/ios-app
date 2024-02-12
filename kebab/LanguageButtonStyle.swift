//
//  AppButtonStyle.swift
//  kebab
//
//  Created by jefferson on 6.02.24.
//

import SwiftUI

struct LanguageButtonStyle: PrimitiveButtonStyle {
    
    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        LanguageButton(configuration: configuration)
    }
}

  struct LanguageButton: View {

    // MARK: State properties

    @State var focused: Bool = false

    // MARK: - Properties

    let configuration: PrimitiveButtonStyle.Configuration

    // MARK: - Body

    var body: some View {
      return GeometryReader { geometry in
        Rectangle()
          .fill(Color.black)
          .overlay(
            configuration.label
              .foregroundColor(.white)
          )
          .cornerRadius(geometry.size.height / 2)
      }
      .scaleEffect(focused ? 1.1 : 1.0)
      .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
      .padding()
      .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
        .onChanged { _ in
          withAnimation {
            self.focused = true
          }
        }
        .onEnded { _ in
          withAnimation {
            self.focused = false
            configuration.trigger()
          }
        })
    }
}
