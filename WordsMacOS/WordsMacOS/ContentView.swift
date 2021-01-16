//
//  ContentView.swift
//  WordsMacOS
//
//  Created by Камиль  Сулейманов on 15.01.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var activeLetters = [String](repeating: "У", count: 4)
    @State private var tray = [String](repeating: "А", count: 10)
    @State private var buttonsFrames = [CGRect](repeating: .zero, count: 4)
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var timeRemaining = 100
    @State private var score = 0
    
    var body: some View {
        VStack {
            HStack{
                GameNumber(text: "Time", value: timeRemaining)
                Text("WORDS")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                
                GameNumber(text: "Score", value: score)
            }
            HStack{
                VStack {
                    Button(action: { resetLettters(deductPoints: true)}, label: {
                        Text("Reset")
                            .font(.headline)
                            .padding(20)
                            .padding(.horizontal, 30)
                            .background(Color.green.cornerRadius(40))
                        
                        
                    })
                    Text("-10 points")
                        .font(.headline)
                        .foregroundColor(.white)
                        .shadow(color: .red, radius:5)
                        .shadow(color: .red, radius:5)
                }
            
                Spacer()
                
                Button(action: {tray.shuffle()}, label: {
                    Text("Shuffle letters")
                        .font(.headline)
                        .padding(20)
                        .background(Color.green.cornerRadius(40))
                })
            }
            .padding(.horizontal)
            .buttonStyle(BorderlessButtonStyle())
            
            Spacer()
            HStack{
                ForEach(0..<4) { number in
                    Letter(text: activeLetters[number], index: number)
                        .allowsHitTesting(false)
                        .overlay( GeometryReader { geo in
                            Color.clear
                                .onAppear{buttonsFrames[number] = geo.frame(in: .global)} })
                }
            }
 
            Spacer()
            
            HStack{
                ForEach(0..<10) { number in
                    Letter(text: tray[number], index: number, onChanged: letterMoved, onEnded: letterDropped)
                }
            }
            .padding()
        }
        .frame(width: 1024, height: 768)
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))]), startPoint: .top, endPoint: .bottom))
        .allowsHitTesting(timeRemaining > 0)
        .onAppear{startGame()}
        .onReceive(timer) { value in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .colorScheme(.light)
    }
    
    func startGame(){
        resetLettters(deductPoints: false)
    }
    
    func resetLettters(deductPoints: Bool) {
        let newWord =  startWords.randomElement()!
        activeLetters = newWord.map(String.init)
        tray = (1...10).map { _ in self.randomLetter()}
        
        if deductPoints {
            score -= 10
        }
    }
    
    func randomLetter() -> String {
        String("ABCDEFFFFFFFGHIJKKKKKKKKLLLLLLLMNOPQRSSSSSSSSTUVWWWWWWWXYZ".randomElement()!)
    }
    
    func letterMoved(location: CGPoint, letter: String) -> DragState {
        if let match = buttonsFrames.firstIndex(where : { $0.contains(location) }) {
            if activeLetters[match] == letter {return .bad}
            
            var testLetters = activeLetters
            testLetters[match] = letter
           
            let testWord = String(testLetters.joined())
            
            if allowedWords.contains(testWord) {
                return .good
            } else {
                return .bad
            }
        } else {
            return .unknown
        }
    }
    
    func letterDropped(location: CGPoint, trayIndex: Int, letter: String) {
        if let match = buttonsFrames.firstIndex(where : { $0.contains(location) }) {
            activeLetters[match] = letter
            
            tray.remove(at: trayIndex)
            tray.append(randomLetter())
            
            timeRemaining += 2
            score += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let allowedWords = ["WIFE", "LITE", "LIKE","LIFE", "SITE"]
let startWords = ["LIFE",]
