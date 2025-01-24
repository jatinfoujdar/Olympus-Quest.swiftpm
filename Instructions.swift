import SwiftUI

struct Instructions: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            // Background image layer
            InfoBackgroundImage()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // App icon at the top
                Image("appiconwithradius")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130)
                    .cornerRadius(30)
                    .padding(.top,50)
                    .shadow(radius: 10)
                
                // Title
                Text("How To Play")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)
                    .foregroundColor(.black)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Instructions content
                        Text("Welcome to *Percy Jackson Trivia* 🎉! In this game, you'll be quizzed on random questions from the *Percy Jackson and the Olympians* books. Your task is to guess the correct answer. Be careful though – guess wrong and you'll lose points! 😱")
                            .font(.body)
                            .foregroundColor(.white)
                            .lineSpacing(6)
                        
                        Text("Here's how it works:")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.top, 10)
                            .foregroundColor(.white)
                        
                        Text("• Each correct answer earns you 5 points.\n• Each incorrect answer causes you to lose 1 point.")
                            .font(.body)
                            .foregroundColor(.white)
                            .lineSpacing(6)
                        
                        Text("Good Luck")
                            .font(.largeTitle)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    
                    
                    Button("Done"){
                        dismiss()
                    }
                    .doneButton()
                    
                }
            }
        }
    }
}

#Preview{
    Instructions()
}
