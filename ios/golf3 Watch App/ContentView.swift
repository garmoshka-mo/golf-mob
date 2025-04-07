//
//  ContentView.swift
//  golf3 Watch App
//
//  Created by dev on 4/7/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
          Button("Speech") {
            sendNumber(3)
          }
        }
        .padding()
    }
  
  @ObservedObject var phoneConnector = PhoneConnector()
  func sendNumber(_ number: Int) {
    print("sending num", number)
    
    if self.phoneConnector.session.isReachable {
    } else {
        print("Session not reachable")
    }
    
    self.phoneConnector.session.sendMessage(["number": number], replyHandler: nil)
    { (error) in
      print("error on sending msg to phone")
      print(error.localizedDescription)
    }
  }
}

#Preview {
    ContentView()
}
