//
//  VPNView.swift
//  JustSomeApp
//
//  Created by jefferson on 30.01.24.
//

import SwiftUI

enum Country: String, CaseIterable, Identifiable {
    case nlRu = "🇳🇱 Netherlands, EU (via Russia)"
    case ru = "🇷🇺 Saint-Petersburg, RU"
    case nl = "🇳🇱 Netherlands, EU"
    case us = "🇺🇸 Fremont CA, USA"
    
    var id: String { self.rawValue }
    
    var getUrl: String {
        switch self {
        case .nlRu:
            "ru-nl-001.tastegateway.com"
        case .ru:
            "ru-001.tastegateway.com"
        case .nl:
            "nl-001.tastegateway.com"
        case .us:
            "us-001.tastegateway.com"
        }
    }
}

struct VPNView: View {
    @ObservedObject var conn: Connector = Connector.main
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text("Pick your country:")
                Picker("", selection: $conn.selectedCountry) {
                    ForEach(Country.allCases, id: \.self) { country in
                        Text(country.rawValue).tag(country)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity)
            }
            .frame(height: 20)
            
            Spacer()
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                VStack {
                    Text("Your IP is: \(conn.ip)")
                    if conn.shouldShowAttempts {
                        Text("Connection attempts: \(conn.attempts)/\(conn.maxAttempts)")
                    } else {
                        EmptyView()
                    }
                }
            }
            .padding()
            Spacer()

            Text(conn.vpnStatus)
                .foregroundColor(conn.isVPNActive ? .green : .red)
                .bold()
                .padding()
            
            Button(action: {
                conn.shouldShowAttempts = false
                conn.isLoading = true
                conn.isButtonDisabled = true
                conn.isVPNActive ? conn.disconnect() : conn.setup(endpoint: conn.selectedCountry)
            }) {
                Text(conn.isVPNConnecting ? "Stop VPN" : "Run VPN")
                    .padding()
                    .foregroundColor(.white)
                    .background(conn.isVPNConnecting ? Color.red : Color.green)
                    .cornerRadius(10)
            }
            .disabled(conn.isButtonDisabled ? true : false)
            .padding()
        }
        .overlay(
            Group {
                if conn.isLoading {
                    LoaderView()
                }
            }
        )
        .padding()
        .onAppear {
            print("status", conn.status)
        }
    }

}

#Preview {
    VPNView()
}
