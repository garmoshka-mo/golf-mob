import SwiftUI
import WatchConnectivity

struct Hole: Identifiable {
    let id = UUID()
    let number: Int
    let position: CGPoint
}

struct ContentView: View {
  @State private var holes: [Hole] = []

  let fieldSize = CGSize(width: 400, height: 480) 

  var body: some View {
      ScrollView([.vertical, .horizontal]) {
          ZStack {
              // Зелёное поле, растянутое под всё содержимое
              Rectangle()
                  .fill(Color.green)
                  .frame(width: fieldSize.width, height: fieldSize.height)

              // Лунки
              ForEach(holes) { hole in
                  HoleView(hole: hole, action: sendNumber)
                      .position(hole.position)
              }
          }
          .frame(width: fieldSize.width, height: fieldSize.height)
          .onAppear {
              generateHoles()
          }
      }
  }


  func generateHoles() {
      let positions: [CGPoint] = [
          CGPoint(x: 50, y: 50),
          CGPoint(x: 150, y: 70),
          CGPoint(x: 250, y: 50),

          CGPoint(x: 50, y: 150),
          CGPoint(x: 130, y: 180),
          CGPoint(x: 250, y: 150),

          CGPoint(x: 100, y: 280),
          CGPoint(x: 200, y: 340)
      ]

      holes = positions.enumerated().map { index, pos in
          Hole(number: index + 1, position: pos)
      }
  }

    func sendNumber(_ number: Int) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(["number": number], replyHandler: nil, errorHandler: nil)
        }
    }
}

struct HoleView: View {
    let hole: Hole
    let action: (Int) -> Void

    @State private var isPressed = false

    var body: some View {
        ZStack(alignment: .top) {
            // Флажок
            VStack(spacing: 2) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 12, height: 10)
                    .offset(x: -6)
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 2, height: 20)
            }

            // Кнопка-лунка
            Button(action: {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = true
                }
                WKInterfaceDevice.current().play(.click)
                action(hole.number)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = false
                    }
                }
            }) {
                Circle()
                    .fill(Color.black.opacity(0.9))
                    .frame(width: 36, height: 36)
                    .scaleEffect(isPressed ? 0.85 : 1.0)
                    .overlay(
                        Text("\(hole.number)")
                            .foregroundColor(.white)
                            .bold()
                    )
            }
            .buttonStyle(PlainButtonStyle())
            .offset(y: 20)
            .frame(width: 36, height: 36)
            .contentShape(Circle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
