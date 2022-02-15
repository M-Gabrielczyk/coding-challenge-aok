//
//  NetworkChecker.swift
//  AppleRepositories
//
//  Created by Michał on 09/02/2022.
//

import Foundation
import Network
import Combine

/// Helper class for check Network connection with NWPathMonitor
class NetworkStatus {

    static public let shared = NetworkStatus()

    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    public var isConnected = PassthroughSubject<Bool, Never>()

     init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }

    // Initialize network monitoring and update isConnected status.
     func startMonitoring() {
        self.monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isConnected.send(true)
            } else {
                self.isConnected.send(false)
            }
        }
    }

     func stopMonitoring() {
        self.monitor.cancel()
    }

}
