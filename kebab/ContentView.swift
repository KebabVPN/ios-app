//
//  ContentView.swift
//  kebab
//
//  Created by Evgeniy Khashin on 27.12.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var conn: Connector

    let URL_US = "us-001.tastegateway.com"
    let URL_EU = "nl-001.tastegateway.com"

    var body: some View {
        VStack() {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)

            if conn.attempts > 0 {
                Text("\(conn.serverAddress) (\(VPNStatus.getStatus(code: conn.status)) - \(conn.attempts)/\(conn.maxAttempts), your IP is: \(conn.ip)")
            } else {
                Text("\(conn.serverAddress) (\(VPNStatus.getStatus(code: conn.status))), your IP is: \(conn.ip)")
            }

            Button {
                conn.setup(endpoint: URL_EU)
            } label: {
                if conn.serverAddress == URL_EU {
                    Text("Run NL (current)").padding(20)
                } else {
                    Text("Run NL").padding(20)
                }
            }

            Button {
                conn.setup(endpoint: URL_US)
            } label: {
                if conn.serverAddress == URL_US {
                    Text("Run US (current)").padding(20)
                } else {
                    Text("Run US").padding(20)
                }
            }

            Button {
                conn.disconnect()
            } label: {
                Text("Disconnect").padding(20)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
