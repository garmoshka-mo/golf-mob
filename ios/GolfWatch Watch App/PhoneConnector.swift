import WatchKit
import WatchConnectivity

final class PhoneConnector: NSObject, ObservableObject {
    var session: WCSession
        init(session: WCSession  = .default) {
      self.session = session
      super.init()
      if WCSession.isSupported() {
          session.delegate = self
          session.activate()
      }
    }
}

extension PhoneConnector: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
   }
    // Added
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        guard let messageFromApp = message["messageFromApp"] as? String else { return }
        DispatchQueue.main.async {
          // todo: https://medium.com/@arnaud.derosin/communicate-between-your-watchos-app-and-your-ios-app-developed-with-react-native-b86ebe153d34
//            self.receivedMessage = messageFromApp
  }
    }
}
