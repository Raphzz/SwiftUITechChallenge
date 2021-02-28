//
//  Reachability+Convinience.swift
//  iOSTechChallenge
//
//  Created by Raphael Pedrini on 27/02/2021.
//

import Foundation
import Reachability

extension Reachability {
    func startReachability(completion: @escaping ((Bool) -> Void)) {
        
        #if DEBUG
        if CommandLine.arguments.contains("-isOfflineMode") {
            completion(false)
            return
        }
        #endif
        
        self.whenReachable = { _ in
            completion(true)
        }
        self.whenUnreachable = { _ in
            completion(false)
        }

        do {
            try self.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
