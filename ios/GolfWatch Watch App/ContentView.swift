import SwiftUI
import WatchConnectivity

struct ContentView: View {
    var body: some View {
        ZStack {
            // Зелёное поле
            Color.green
                .ignoresSafeArea()

            // Лунки-гольф
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    GolfHole(number: 1, position: CGPoint(x: 50, y: 50), action: sendNumber)
                    Spacer()
                    GolfHole(number: 2, position: CGPoint(x: 100, y: 100), action: sendNumber)
                    Spacer()
                    GolfHole(number: 3, position: CGPoint(x: 150, y: 50), action: sendNumber)
                    Spacer()
                }
                Spacer()
            }
        }
    }

    func sendNumber(_ number: Int) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(["number": number], replyHandler: nil, errorHandler: nil)
        }
    }
}

struct GolfHole: View {
    let number: Int
    let position: CGPoint
    let action: (Int) -> Void

    var body: some View {
        Button(action: { action(number) }) {
            ZStack {
                Circle()
                    .fill(Color.black)
                    .frame(width: 40, height: 40)
                Text("\(number)")
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
