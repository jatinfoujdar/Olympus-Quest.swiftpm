import Foundation
import SwiftUI

enum Constant {
    static let hpFont = "PartyLetPlain"
}

struct InfoBackgroundImage: View{
    var body: some View{
        Image("parchment")
            .resizable()
            .ignoresSafeArea()
            .background(.brown)
    }
}

extension Button{
    @MainActor func doneButton() -> some View{
        self
            .font(.largeTitle)
            .padding()
            .buttonStyle(.borderedProminent)
            .tint(.brown)
            .foregroundColor(.white)
    }
}
