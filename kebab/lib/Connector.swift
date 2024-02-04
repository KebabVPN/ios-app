//
//  connector.swift
//  kebab
//
//  Created by Evgeniy Khashin on 28.12.2023.
//

import Foundation
import NetworkExtension
import Security

class Connector: ObservableObject {
    static let main = Connector()

    let IPurl = URL(string: "https://ifconfig.me/ip")!
    @Published var ip = ""
    @Published var serverAddress = ""
    @Published var status = -1
    @Published var attempts = 0

    let NEVPNStatusVoid = -1
    let maxAttempts = 10
    var nextAction = -1
    
    let params = Params()

    let vpnManager = NEVPNManager.shared()

    private init() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.NEVPNStatusDidChange, object: nil , queue: nil) { [self]
           notification in

            self.status = self.vpnManager.connection.status.rawValue
            self.serverAddress = self.vpnManager.protocolConfiguration?.serverAddress ?? "Unknown"
            if self.nextAction == NEVPNStatus.connected.rawValue && self.status == NEVPNStatus.connected.rawValue {
                self.nextAction = self.NEVPNStatusVoid
            }
            if self.nextAction == NEVPNStatus.connected.rawValue && self.status == NEVPNStatus.disconnected.rawValue {
                self.attempts += 1
                if attempts < maxAttempts {
                    DispatchQueue.global(qos: .userInteractive).async {
                        self.connect()
                    }
                } else {
                    self.nextAction = self.NEVPNStatusVoid
                    attempts = 0
                }
            }
            if self.status == NEVPNStatus.disconnected.rawValue || self.status == NEVPNStatus.connected.rawValue {
                 self.updateIP()
            }
        }
    }

    func updateIP() {
        URLSession.shared.dataTask(with: self.IPurl) { data, response, error in
            DispatchQueue.main.async {
                self.ip = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
            }
        }.resume()
    }

    func initWithPreferences() {
        self.vpnManager.localizedDescription = Constants.ConnectionName
        self.vpnManager.loadFromPreferences { error in
            if let error = error {
                print("Failed to load preferences: \(error.localizedDescription)")
            }
        }
    }

    func setup(endpoint: String) {
        let p = NEVPNProtocolIKEv2()
        p.authenticationMethod = .none
        p.serverAddress = endpoint
        p.remoteIdentifier = endpoint
        p.useExtendedAuthentication = true

        p.ikeSecurityAssociationParameters.encryptionAlgorithm = .algorithmAES256GCM
        p.ikeSecurityAssociationParameters.diffieHellmanGroup = .group20
        p.ikeSecurityAssociationParameters.integrityAlgorithm = .SHA384
        p.ikeSecurityAssociationParameters.lifetimeMinutes = 1440

        p.childSecurityAssociationParameters.encryptionAlgorithm = .algorithmAES256GCM
        p.childSecurityAssociationParameters.diffieHellmanGroup = .group20
        p.childSecurityAssociationParameters.integrityAlgorithm = .SHA384
        p.childSecurityAssociationParameters.lifetimeMinutes = 1440

        p.deadPeerDetectionRate = .medium
        p.disableRedirect = false
        p.disableMOBIKE = false
        p.enableRevocationCheck = false
        p.enablePFS = true
        p.useConfigurationAttributeInternalIPSubnet = false

        p.username = params.username
        let passw = params.password
        
        let kcs = KeychainService();
        kcs.save(key: "PASSWORD", value: passw)

        p.passwordReference = kcs.load(key: "PASSWORD")

        self.vpnManager.protocolConfiguration = p
        self.vpnManager.isEnabled = true
        self.vpnManager.isOnDemandEnabled = false
        self.vpnManager.saveToPreferences(completionHandler: self.vpnSaveHandler)
    }

    private var vpnSaveHandler: (Error?) -> Void {
        return { (error:Error?) in
            if (error != nil) {
                print("Could not save VPN Configurations")
                return
            } else {
                self.nextAction = NEVPNStatus.connected.rawValue
                self.connect()
            }
            self.initWithPreferences()
        }
    }

    func connect() {
        do {
            try self.vpnManager.connection.startVPNTunnel()
        } catch let error {
            print("Error starting VPN Connection \(error.localizedDescription)");
        }
    }

    func disconnect() {
        self.vpnManager.connection.stopVPNTunnel()
    }
}
