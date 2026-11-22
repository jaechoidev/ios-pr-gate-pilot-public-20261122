import SwiftUI

@main
struct CounterPilotApp: App {
    @State private var count = 0

    var body: some Scene {
        WindowGroup {
            VStack(spacing: 20) {
                Text(String(count))
                    .accessibilityIdentifier("counter-value")
                Button("Increment") { count += 1 }
                    .accessibilityIdentifier("increment")
            }
            .padding()
        }
    }
}
