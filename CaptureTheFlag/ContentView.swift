//
//  ContentView.swift
//  CaptureTheFlag
//
//  Created by Sumayyah on 12/03/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    // Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert.
    @State private var score = 0

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
        VStack(spacing: 30) {
        VStack {
            Text("Tap the flag of").foregroundColor(.white)
            Text(countries[correctAnswer])
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.black)
        }
        ForEach(0..<3) { number in
            Button(action: {
                self.flagTapped(number)
            }) {
                FlagImage(name: self.countries[number])
            }
            
            Spacer()
        }
            // Show the player’s current score in a label directly below the flags
            Text("Your score is \(score)").foregroundColor(.white)
    }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        }
        else {
            //When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
            scoreTitle = "Wrong! Thats the flag of \(countries[number])"
            score = score - 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

/// Renders flag image
struct FlagImage: View {
    let name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
