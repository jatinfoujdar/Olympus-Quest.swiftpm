import SwiftUI

struct Gameplay: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var animationViewIn = false
    @State private var tappedCorrectAnswer = false
    @State private var hintWiggle = false
    @State private var scaleNextButton = false
    @State private var movePoints = false
    @State private var revealHint = false
    @State private var revealBooks = false
    
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
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))
                        
                        Spacer()
                        
                        Text("Score: 55")
                    }
                    .padding()
                    .padding(.vertical,30)
                    
                    VStack{
                        if animationViewIn{
                            Text("Who is Percy Jackson?")
                                .font(.custom(Constant.hpFont, size: 50))
                                .multilineTextAlignment(.center)
                                .padding()
                                .transition(.scale)
                        }
                    }
                    .animation(.easeInOut(duration: 2), value: animationViewIn)
                                       
                    Spacer()
                    
                    
                    HStack{
                        VStack{
                            if animationViewIn{
                                Image(systemName: "questionmark.app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .foregroundStyle(.cyan)
                                    .rotationEffect(.degrees(hintWiggle ? -13 : -17))
                                    .padding()
                                    .padding(.leading,20)
                                    .transition(.offset(x: -geo.size.width/2))
                                    .onAppear {
                                        withAnimation(                                           .easeInOut(duration: 0.1)
                                            .repeatCount(9)
                                            .delay(5)
                                            .repeatForever()){
                                                hintWiggle = true
                                            }
                                    }
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 1)){
                                            revealHint = true
                                        }
                                    }
                                    .rotation3DEffect(.degrees(revealHint ? 1440 : 0), axis: (x: 0, y: 1, z: 0))
                                    .scaleEffect(revealHint ? 5 : 1)
                                    .opacity(revealHint ? 0 : 1)
                                    .offset(x: revealHint ? geo.size.width/2 : 0)
                                    .overlay(
                                        Text("The Boy Who _______")
                                            .padding(.leading,33)
                                            .minimumScaleFactor(0.5)
                                            .multilineTextAlignment(.center)
                                            .opacity(revealHint ? 1 : 0)
                                            .scaleEffect(revealHint ? 1.33 : 1)
                                    )
                            }
                        }
                        .animation(.easeOut(duration: 1.5).delay(2), value: animationViewIn)
                        Spacer()
                        
                        VStack{
                            if animationViewIn{
                                Image(systemName: "book.closed")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundStyle(.black)
                                    .frame(width: 100, height: 100)
                                    .background(.cyan)
                                    .cornerRadius(20)
                                    .rotationEffect(.degrees(hintWiggle ? 13 : 17))
                                    .padding()
                                    .padding(.trailing,20)
                                    .transition(.offset(x: geo.size.width/2))
                                    .onAppear {
                                        withAnimation(                                           .easeInOut(duration: 0.1)
                                                .repeatCount(9)
                                                .delay(5)
                                                .repeatForever()){
                                                    hintWiggle = true
                                                }
                                    }
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 1)){
                                            revealBooks = true
                                        }
                                    }
                                    .rotation3DEffect(.degrees(revealBooks ? 1440 : 0), axis: (x: 0, y: 1, z: 0))
                                    .scaleEffect(revealBooks ? 5 : 1)
                                    .opacity(revealBooks ? 0 : 1)
                                    .offset(x: revealBooks ? -geo.size.width/2 : 0)
                                    .overlay(
                                        Image("hp1")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(.trailing,33)
                                            .opacity(revealBooks ? 1 : 0)
                                            .scaleEffect(revealBooks ? 1.33 : 1)
                                    )
                                   
                            }
                        }
                        .animation(.easeOut(duration: 1.5).delay(2), value: animationViewIn)
                    }
                    .padding()
                    
                    LazyVGrid(columns: [GridItem(), GridItem()]){
                        ForEach(1..<5) { i in
                            VStack{
                                if animationViewIn{
                                    Text("Answer \(i)")
                                        .minimumScaleFactor(0.5)
                                        .multilineTextAlignment(.center)
                                        .padding(10)
                                        .frame(width: geo.size.width/2.15, height: 80)
                                        .background(.green.opacity(0.5))
                                        .cornerRadius(25)
                                        .transition(.offset(x: -geo.size.width/2))
                                       
                                }
                            }
                            .animation(.easeOut(duration: 1).delay(1.5), value: animationViewIn)
                        }
                    }
                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .foregroundColor(.white)
                
                VStack{
                    Spacer()
                    
                    VStack{
                        if tappedCorrectAnswer{
                            Text("5")
                                .font(.largeTitle)
                                .padding(.top,50)
                                .transition(.offset(y: -geo.size.height/4))
                                .offset(x: movePoints ? geo.size.width/2.3 : 0 , y: movePoints ? -geo.size.height/13 : 0)
                                .opacity(movePoints ? 0 : 1)
                                .onAppear{
                                    withAnimation(.easeInOut(duration: 1).delay(3)){
                                        movePoints = true
                                    }
                                }
                        }
                    }
                        .animation(.easeInOut(duration: 1).delay(2), value: tappedCorrectAnswer )
                    
                    Spacer()
                    
                    VStack{
                        if tappedCorrectAnswer{
                            Text("Brilliant!")
                                .font(.custom(Constant.hpFont, size: 100))
                                .transition(.scale.combined(with: .offset(y: -geo.size.height/2)))
                        }
                    }
                    .animation(.easeInOut(duration: 1).delay(1), value: tappedCorrectAnswer)
                    
                    Spacer()
                    
                    if tappedCorrectAnswer{
                        Text("Answer 1")
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: geo.size.width/2.15, height: 80)
                            .background(.green.opacity(0.5))
                            .cornerRadius(25)
                            .scaleEffect(2)
                    }
                        
                    
                    Group{
                        Spacer()
                        Spacer()
                    }
                    
                    VStack{
                        if tappedCorrectAnswer{
                            Button("Next Level"){
                                
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.blue.opacity(0.5))
                            .font(.largeTitle)
                            .transition(.scale.combined(with: .offset(y: geo.size.height/3)))
                            .scaleEffect(scaleNextButton ? 1.2 : 1)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                                    scaleNextButton.toggle()
                                }
                            }
                        }
                    }
                    .animation(.easeInOut(duration: 2.7).delay(2.7), value: tappedCorrectAnswer)
                    
                    Group{
                        Spacer()
                        Spacer()
                    }
                }
                .foregroundStyle(.white)
        
    
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .onAppear{
            animationViewIn = true
//            tappedCorrectAnswer = true
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    Gameplay()
}
