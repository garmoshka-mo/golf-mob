import SwiftUI
import WatchKit

struct ContentView: View {
    @State private var transcript = "Press 'Speech' to speak"
    @State private var showFieldView = false

    var body: some View {
        VStack(spacing: 10) {
            Text(transcript)
                .padding()

            Button("Speech") {
                presentVoiceInput()
            }
            .tint(.green)

            NavigationLink("Field", destination: FieldView())
                .tint(.blue)
        }
    }

    func presentVoiceInput() {
        WKExtension.shared().visibleInterfaceController?.presentTextInputController(
            withSuggestions: nil,
            allowedInputMode: .plain
        ) { result in
            if let result = result?.first as? String {
                transcript = result
            } else {
                transcript = "No input received"
            }
        }
    }
}
