//
//  NetworkMonitor.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 02.04.2024.
//

import Foundation
import Network

final class NetworkMonitor {
    
    static let shared = NetworkMonitor()
        
    private let queue = DispatchQueue(label: "NetworkMonitor", qos: .utility)
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi
        case cellular
        case unknown
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            self.connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            self.connectionType = .cellular
        } else {
            connectionType = .unknown
        }
    }
}
