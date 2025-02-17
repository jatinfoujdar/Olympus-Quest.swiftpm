import SwiftUI
import AVKit

struct ContentView: View {
    @EnvironmentObject private var game: Game
    
    @State private var audioPlayer: AVAudioPlayer!
    @State private var scalePlayButton = false
    @State private var moveBackgroundImage = false
    @State private var animateViewIn = false
    @State private var showInstruction = false
    @State private var showSetting = false
    @State private var playGame = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    .offset(x: moveBackgroundImage ? geo.size.width / 1.1 : -geo.size.width / 1.1)
                    .onAppear {
                        withAnimation(.linear(duration: 60).repeatForever()) {
                            moveBackgroundImage.toggle()
                        }
                    }
                
                VStack {
                    VStack {
                        if animateViewIn {
                            VStack {
                                Image(systemName: "bolt.fill")
                                    .foregroundStyle(.yellow)
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                
                                Text("Olympus Quest")
                                    .font(.custom("PartyLetPlain", size: 70))
                                    .overlay(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.orange, .red, .purple, .blue]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                        .mask(Text("Olympus Quest")
                                            .font(.custom("PartyLetPlain", size: 70))
                                        )
                                    )
                                
                                Text("Trivia")
                                    .font(.custom("PartyLetPlain", size: 60))
                                    .overlay(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.orange, .red, .purple, .blue]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                        .mask(Text("Trivia")
                                            .font(.custom("PartyLetPlain", size: 60))
                                        )
                                    )
                            }
                            .padding(.top, 70)
                            .transition(.move(edge: .top))
                        }
                    }
                    .animation(.easeOut(duration: 0.7).delay(2), value: animateViewIn)
                    
                    Spacer()
                    
                    VStack {
                        if animateViewIn {
                            VStack {
                                Text("Recent Scores")
                                    .font(.title2)
                                    .padding()
                                
                                ForEach(game.recentScore, id: \.self) { score in
                                    Text("\(score)")
                                }
                            }
                            .font(.title3)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .background(.black.opacity(0.7))
                            .cornerRadius(15)
                            .transition(.opacity)
                        }
                    }
                    .animation(.linear(duration: 0.7).delay(2), value: animateViewIn)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            if animateViewIn {
                                Button {
                                    showInstruction.toggle()
                                } label: {
                                    Image(systemName: "info.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .shadow(radius: 5)
                                }
                                .transition(.offset(x: -geo.size.height / 4))
                                .sheet(isPresented: $showInstruction) {
                                    Instructions()
                                }
                            }
                        }
                        .animation(.easeOut(duration: 0.7).delay(2), value: animateViewIn)
                        
                        Spacer()
                        
                        VStack {
                            if animateViewIn {
                                Button {
                                    game.startGame()
                                    playGame.toggle()
                                } label: {
                                    Text("Play")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 50)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [.blue, .purple]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .cornerRadius(15)
                                        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                                }
                                .scaleEffect(scalePlayButton ? 1.1 : 1)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                                        scalePlayButton.toggle()
                                    }
                                }
                                .transition(.offset(y: geo.size.height / 3))
                                .fullScreenCover(isPresented: $playGame) {
                                    Gameplay()
                                        .environmentObject(game)
                                        .onAppear{
                                            audioPlayer.setVolume(0, fadeDuration: 2)
                                        }
                                        .onDisappear{
                                            audioPlayer.setVolume(1, fadeDuration: 3)
                                        }
                                }
                            }
                        }
                        .animation(.easeOut(duration: 0.7).delay(2), value: animateViewIn)
                        
                        Spacer()
                        
                        VStack {
                            if animateViewIn {
                                Button {
                                    showSetting.toggle()
                                } label: {
                                    Image(systemName: "gearshape.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .shadow(radius: 5)
                                }
                                .transition(.offset(x: geo.size.height / 4))
                                .sheet(isPresented: $showSetting) {
                                    Setting()
                                        .environmentObject(game)
                                }
                            }
                        }
                        .animation(.easeOut(duration: 0.7).delay(2), value: animateViewIn)
                        
                        Spacer()
                    }
                    .frame(width: geo.size.width)
                    
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            animateViewIn = true
            playAudio()
        }
        .preferredColorScheme(.dark)
    }
    
    private func playAudio() {
        guard let soundURL = Bundle.main.url(forResource: "magicintheair", withExtension: "mp3") else {
            print("Audio file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            print("Error initializing player: \(error)")
        }
    }
}
