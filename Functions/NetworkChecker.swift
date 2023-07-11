//
//  NetworkChecker.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 06/07/2023.
//
import Network

class NetworkChecker {

    static let shared = NetworkChecker()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    private init(){
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            isConnected = path.status != .unsatisfied
            print(isConnected)
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }

}
