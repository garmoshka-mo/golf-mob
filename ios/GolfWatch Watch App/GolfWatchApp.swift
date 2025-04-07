//
//  GolfWatchApp.swift
//  GolfWatch Watch App
//
//  Created by dev on 4/7/25.
//

import SwiftUI
import WatchConnectivity

@main
struct GolfWatch_Watch_AppApp: App {
  
  init() {
      WCSession.default.delegate = WatchSessionDelegate()
      WCSession.default.activate()
  }
  
  var body: some Scene {
      WindowGroup {
          NavigationView {
              ContentView()
          }
      }
  }
  
}

class WatchSessionDelegate: NSObject, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
}
