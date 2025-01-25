import SwiftUI

struct Setting: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack{
            InfoBackgroundImage()
            
            VStack{
                Text("Which Books would like to see question from?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                
                ScrollView{
                    
                }
                
                Button("Done"){
                    dismiss()
                }
                .doneButton()
            }
        }
    }
}

#Preview {
    Setting()
}
