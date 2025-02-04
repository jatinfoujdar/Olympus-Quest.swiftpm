import Foundation
import SwiftUI

enum Constant {
    static let hpFont = "PartyLetPlain"
    static let PJFont = "Savoye LET"
    // Safely load and decode the trivia JSON file
    static let previewQuestion: Question = {
        guard let url = Bundle.main.url(forResource: "trivia", withExtension: "json") else {
            fatalError("Failed to locate trivia.json in bundle.")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let questions = try JSONDecoder().decode([Question].self, from: data)
            return questions[0]
        } catch {
            fatalError("Failed to decode trivia.json: \(error.localizedDescription)")
        }
    }()
}

struct InfoBackgroundImage: View {
    var body: some View {
        Image("parchment")
            .resizable()
            .ignoresSafeArea()
            .background(.brown)
    }
}

extension Button {
    @MainActor func doneButton() -> some View {
        self
            .font(.largeTitle)
            .padding()
            .buttonStyle(.borderedProminent)
            .tint(.brown)
            .foregroundColor(.white)
    }
}


