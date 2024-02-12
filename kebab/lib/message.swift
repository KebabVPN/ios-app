//
//  constants.swift
//  kebab
//
//  Created by Evgeniy Khashin on 29.12.2023.
//

import Foundation
import NetworkExtension

class Message {
    static func status(code: Int) -> String {
        switch code {
        case NEVPNStatus.invalid.rawValue:
          return "Invalid"
        case NEVPNStatus.disconnected.rawValue:
          return "Disconnected"
        case NEVPNStatus.connecting.rawValue:
          return "Connecting"
        case NEVPNStatus.connected.rawValue:
          return "Connected"
        case NEVPNStatus.reasserting.rawValue:
          return "Reasserting"
        case NEVPNStatus.disconnecting.rawValue:
          return "Disconnecting"
        default:
            return "Unknown"
        }
    }
}
