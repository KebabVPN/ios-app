//
//  VPNManager.swift
//  JustSomeApp
//
//  Created by jefferson on 31.01.24.
//

import Foundation

class VPNManager {
    func connectToFakeServer(country: Country, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    func disconnect(completion: @escaping () -> Void) {
        completion()
    }
}
