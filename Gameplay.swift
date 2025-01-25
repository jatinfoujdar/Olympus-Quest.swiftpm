import SwiftUI

struct Gameplay: View {
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Image(.hogwarts)
                    .resizable()
                    .frame(width: geo.size.width * 3 , height: geo.size.height * 1.05)
                    .overlay(Rectangle().foregroundColor(.black.opacity(0.8)))
                
                VStack{
                    HStack{
                        Button("End Game"){
                            
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))
                        
                        Spacer()
                        
                        Text("Score: 55")
                    }
                    .padding()
                    Text("Who is Percy Jackson?")
                        .font(.custom(Constant.hpFont, size: 50))
                    
                    HStack{
                        Image(systemName: "questionmark.app.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .foregroundStyle(.cyan)
                            .rotationEffect(.degrees(-15))
                            .padding()
                            .padding(.leading,20)
                        
                        Spacer()
                        
                        Image(systemName: "book.closed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .foregroundStyle(.black)
                            .frame(width: 100, height: 100)
                            .background(.cyan)
                            .cornerRadius(20)
                            .rotationEffect(.degrees(15))
                            .padding()
                            .padding(.trailing,20)
                    }
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .foregroundColor(.white)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Gameplay()
}
