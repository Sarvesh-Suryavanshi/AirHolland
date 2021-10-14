//
//  NeworkMonitor.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 13/10/21.
//

import Network

/// Network Manager class  responsible for monitoring network status and reachability change
final class NeworkMonitor {
    
    //MARK: - Connection Type Enum Declaration

    /// Network connection type enum
    enum ConnectionType {
        
        case wifi
        case cellular
        case ethernet
        case unknown
        
        init?(rawValue: NWPath) {
            if rawValue.usesInterfaceType(.wifi) {
                self = .wifi
            } else if rawValue.usesInterfaceType(.cellular) {
                self = .cellular
            } else if rawValue.usesInterfaceType(.wiredEthernet) {
                self = .ethernet
            } else {
                self = .unknown
            }
        }
    }
    
    //MARK: - Properties

    static let shared = NeworkMonitor()
    private let monitor: NWPathMonitor
    private let queie: DispatchQueue = DispatchQueue(label: "MONITOR")
    
    private(set) var isConnected: Bool = true
    private(set) var connectionType: ConnectionType = .unknown

    //MARK: - Initializer
    
    private init() {
        self.monitor = NWPathMonitor()
    }
    
    //MARK: - Functions
    
    func startMonitoring() {
        self.monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected =  !(path.status == .unsatisfied)
                self?.connectionType = ConnectionType(rawValue: path) ?? .unknown
            }
        }
        self.monitor.start(queue: self.queie)
    }
    
    func stopMonitoring() {
        self.monitor.cancel()
    }
}
