//
//  constants.swift
//  kebab
//
//  Created by Evgeniy Khashin on 29.12.2023.
//

import SwiftUI
import NetworkExtension

enum VPNStatus {
    static func getStatus(code: Int) -> LocalizedStringKey {
        switch code {
        case NEVPNStatus.invalid.rawValue: 
            LocalizedStringKey("Invalid")
        case NEVPNStatus.disconnected.rawValue: 
            LocalizedStringKey("Disconnected")
        case NEVPNStatus.connecting.rawValue: 
            LocalizedStringKey("Connecting")
        case NEVPNStatus.connected.rawValue: 
            LocalizedStringKey("Connected")
        case NEVPNStatus.reasserting.rawValue: 
            LocalizedStringKey("Reasserting")
        case NEVPNStatus.disconnecting.rawValue: 
            LocalizedStringKey("Disconnecting")
        default: 
            LocalizedStringKey("Not running")
        }
    }
}
