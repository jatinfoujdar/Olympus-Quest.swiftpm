import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    
                
                VStack{
                    VStack{
                        Image(systemName: "bolt.fill")
                            .font(.largeTitle)
                            .imageScale(.large)
                        
                        Text("Olumpus Quest")
                            .font(.custom( Constant.hpFont, size: 70))
                        
                            .padding(.bottom, -50)
                        
                        Text("Trivia")
                            .font(.custom( Constant.hpFont, size: 60))
                    }
                    .padding(.top,70)
                    
                    Spacer()
                    
                    VStack{
                        Text("Recent Scores")
                            .font(.title2)
                            .padding()
                        
                        Text("33")
                        Text("66")
                        Text("66")
                    }
                    .font(.title3)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.7))
                    .cornerRadius(15)
                    
                    Spacer()
                    HStack{
                        Spacer()
                        Button{
                            //instruction
                        }label: {
                            Image(systemName: "info.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        }
                        
                        Spacer()
                        
                        Button{
                            //start
                        }label: {
                            Text("Play")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(.vertical,7)
                                .padding(.horizontal, 50)
                                .background(.brown)
                                .cornerRadius(7)
                                .shadow(radius: 5)
                        }
                        Spacer()
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "gearshape.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        }
                        Spacer()
                    }
                    .frame(width: geo.size.width)
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}
