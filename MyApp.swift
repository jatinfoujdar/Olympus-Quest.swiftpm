import SwiftUI

@main
struct MyApp: App {
    @StateObject private var game = Game()  
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(game)
        }
    }
}
