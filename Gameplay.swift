import SwiftUI
import AVKit


struct Gameplay: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var game : Game
    
    @Namespace private var namespace
    
    @State private var musicPlayer : AVAudioPlayer!
    @State private var sfxPlayer : AVAudioPlayer!
    
    @State private var animationViewIn = false
    @State private var tappedCorrectAnswer = false
    @State private var hintWiggle = false
    @State private var scaleNextButton = false
    @State private var movePoints = false
    @State private var revealHint = false
    @State private var revealBooks = false
    @State private var wrongAnswerTapped : [Int] = []
    
    let tempAnswers = [true,false,false,false]
    
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Image("hogwarts")
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
                                .opacity(tappedCorrectAnswer ? 0.1 : 1)
                        }
                    }
                    .animation(.easeInOut(duration: animationViewIn ? 2 : 0), value: animationViewIn)
                    
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
                                        withAnimation(
                                            .easeInOut(duration: 0.1)
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
                                        playFlipSound()
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
                                    .opacity(tappedCorrectAnswer ? 0.1 : 1)
                                    .disabled(tappedCorrectAnswer)
                            }
                        }
                        .animation(.easeOut(duration: animationViewIn ? 1.5 : 0).delay(animationViewIn ? 2 : 0), value: animationViewIn)
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
                                        withAnimation(
                                            .easeInOut(duration: 0.1)
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
                                        playFlipSound()
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
                                    .opacity(tappedCorrectAnswer ? 0.1 : 1)
                                    .disabled(tappedCorrectAnswer)
                            }
                        }
                        .animation(.easeOut(duration: animationViewIn ? 1.5 : 0).delay(animationViewIn ? 2 : 0), value: animationViewIn)
                    }
                    .padding()
                    
                    LazyVGrid(columns: [GridItem(), GridItem()]){
                        ForEach(1..<5) { i in
                            if tempAnswers[i-1] == true {
                                VStack{
                                    if animationViewIn{
                                        if tappedCorrectAnswer == false{
                                            Text("Answer \(i)")
                                                .minimumScaleFactor(0.5)
                                                .multilineTextAlignment(.center)
                                                .padding(10)
                                                .frame(width: geo.size.width/2.15, height: 80)
                                                .background(.green.opacity(0.5))
                                                .cornerRadius(25)
                                                .transition(.asymmetric(insertion: .scale, removal: .scale(scale: 5).combined(with: .opacity.animation(.easeOut(duration: 0.5)))))
                                                .matchedGeometryEffect(id: "answer", in: namespace)
                                                .onTapGesture {
                                                    withAnimation(.easeOut(duration: 1)){
                                                        tappedCorrectAnswer = true
                                                    }
                                                    playCorrectSound()
                                                }
                                        }
                                    }
                                }
                                .animation(.easeOut(duration: animationViewIn ? 1 : 0).delay(animationViewIn ? 1.5 : 0), value: animationViewIn)
                            } else{
                                VStack{
                                    if animationViewIn{
                                        Text("Answer \(i)")
                                            .minimumScaleFactor(0.5)
                                            .multilineTextAlignment(.center)
                                            .padding(10)
                                            .frame(width: geo.size.width/2.15, height: 80)
                                            .background(wrongAnswerTapped.contains(i) ? .red.opacity(0.5) : .green.opacity(0.5))
                                            .cornerRadius(25)
                                            .transition(.scale)
                                            .onTapGesture {
                                                withAnimation(.easeOut(duration: 0.3)) {
                                                    wrongAnswerTapped.append(i)
                                                }
                                                playWrongSound()
                                            }
                                            .scaleEffect(wrongAnswerTapped.contains(i) ? 0.8 : 1)
                                            .disabled(tappedCorrectAnswer ||  wrongAnswerTapped.contains(i))
                                            .opacity(tappedCorrectAnswer ? 0.1 : 1)
                                        
                                    }
                                }
                                .animation(.easeOut(duration: animationViewIn ? 1 : 0).delay(animationViewIn ? 1.5 : 0), value: animationViewIn)
                            }
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
                    .animation(.easeInOut(duration: tappedCorrectAnswer ? 1 : 0).delay(tappedCorrectAnswer ? 1 : 0), value: tappedCorrectAnswer)
                    
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
                            .matchedGeometryEffect(id: "answer", in: namespace)
                    }
                    
                    
                    Group{
                        Spacer()
                        Spacer()
                    }
                    
                    VStack{
                        if tappedCorrectAnswer{
                            Button("Next Level"){
                                animationViewIn = false
                                tappedCorrectAnswer = false
                                revealBooks = false
                                revealHint = false
                                movePoints = false
                                wrongAnswerTapped = []
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                    animationViewIn = true
                                }
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
                    .animation(.easeInOut(duration:tappedCorrectAnswer ? 2.7 : 0).delay(tappedCorrectAnswer ? 2.7 : 0), value: tappedCorrectAnswer)
                    
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
            playMusic()
        }
        .ignoresSafeArea()
    }
    
    
    
    private func playMusic() {
        let songs = ["let-the-mystery-unfold", "spellcraft", "hiding-place-in-the-forest", "deep-in-the-dell"]
        
        let i = Int.random(in: 0..<songs.count)  // safer random index generation
        
        // Get the URL of the selected song
        guard let songURL = Bundle.main.url(forResource: songs[i], withExtension: "mp3") else {
            print("Song not found.")
            return
        }
        
        do {
            // Initialize the AVAudioPlayer with the correct song URL
            musicPlayer = try AVAudioPlayer(contentsOf: songURL)
            musicPlayer?.numberOfLoops = -1  // Loop the song indefinitely
            musicPlayer?.play()
        } catch {
            print("Error initializing player: \(error)")
        }
    }
    
    private func playFlipSound() {
        guard let soundURL = Bundle.main.url(forResource: "page-flip", withExtension: "mp3") else {
            print("Page flip sound not found.")
            return
        }
        
        do {
            sfxPlayer = try AVAudioPlayer(contentsOf: soundURL)
            sfxPlayer?.play()
        } catch {
            print("Error playing flip sound: \(error)")
        }
    }
    
    private func playWrongSound() {
        guard let soundURL = Bundle.main.url(forResource: "negative-beeps", withExtension: "mp3") else {
            print("Wrong sound not found.")
            return
        }
        
        do {
            sfxPlayer = try AVAudioPlayer(contentsOf: soundURL)
            sfxPlayer?.play()
        } catch {
            print("Error playing wrong sound: \(error)")
        }
    }
    
    private func playCorrectSound() {
        guard let soundURL = Bundle.main.url(forResource: "magic-wand", withExtension: "mp3") else {
            print("Correct sound not found.")
            return
        }
        
        do {
            sfxPlayer = try AVAudioPlayer(contentsOf: soundURL)
            sfxPlayer?.play()
        } catch {
            print("Error playing correct sound: \(error)")
        }
    }
}




#Preview {
    Gameplay()
        .environmentObject(Game())
}
