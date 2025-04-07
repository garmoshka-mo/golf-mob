//
//  ContentView.swift
//  GolfWatch Watch App
//
//  Created by dev on 4/7/25.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
  var body: some View {
      VStack(spacing: 20) {
          Button("1") { sendNumber(1) }
          Button("2") { sendNumber(2) }
          Button("3") { sendNumber(3) }
      }
  }

  func sendNumber(_ number: Int) {
      if WCSession.default.isReachable {
          WCSession.default.sendMessage(["number": number], replyHandler: nil, errorHandler: nil)
      }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 

#Preview {
    ContentView()
}
