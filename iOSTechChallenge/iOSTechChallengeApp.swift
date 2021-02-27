//
//  iOSTechChallengeApp.swift
//  iOSTechChallenge
//
//  Created by Raphael Pedrini on 26/02/2021.
//

import SwiftUI
import Reachability

@main
struct iOSTechChallengeApp: App {
    
    private let reachability = try! Reachability()
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
    
    init() {
        startReachability()
    }
    
    private func startReachability() {
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
