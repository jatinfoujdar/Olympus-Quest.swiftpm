import SwiftUI

struct Gameplay: View {
    
    @State private var animationViewIn = false
    
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
                                    .rotationEffect(.degrees(-15))
                                    .padding()
                                    .padding(.leading,20)
                                    .transition(.offset(x: -geo.size.width/2))
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
                                    .rotationEffect(.degrees(15))
                                    .padding()
                                    .padding(.trailing,20)
                                    .transition(.offset(x: geo.size.width/2))
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
                    
                    Text("5")
                        .font(.largeTitle)
                        .padding(.top,50)
                    Spacer()
                    
                    Text("Brilliant!")
                        .font(.custom(Constant.hpFont, size: 100))
                    
                    Spacer()
                    
                    Text("Answer 1")
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: geo.size.width/2.15, height: 80)
                        .background(.green.opacity(0.5))
                        .cornerRadius(25)
                        .scaleEffect(2)
                    Group{
                        Spacer()
                        Spacer()
                    }
                        Button("Next Level"){
                            
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue.opacity(0.5))
                        .font(.largeTitle)
                   
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
//            animationViewIn = true
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    Gameplay()
}
