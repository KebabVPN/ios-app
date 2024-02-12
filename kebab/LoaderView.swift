//
//  LoaderView.swift
//  JustSomeApp
//
//  Created by jefferson on 30.01.24.
//

import SwiftUI

struct LoaderView: View {
    @State private var degree = 270
    @State private var spinnerLength = 0.6
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0,to: spinnerLength)
                .stroke(LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                .animation(Animation.easeIn(duration: 1.5).repeatForever(autoreverses: true), value: spinnerLength)
                .frame(width: 60, height: 60)
                .rotationEffect(Angle(degrees: Double(degree)))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: spinnerLength)
                .onAppear {
                    degree = 270 + 360
                    spinnerLength = 0
                }
        }
    }
}

#Preview {
    LoaderView()
}
