//
//  ContentView.swift
//  Edutainment
//
//  Created by Adriano Valumin on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    @State var optionNumberOfQuestions = [5, 10, 20]
    @State var numberOfQuestions = 5
    @State var multiplicationTable = Int.random(in: 2 ... 12)
    @State var gameOver = false
    @State var gameSettings = true
    @State var answer: [String] = []
    @State var userScore = 0

    @State private var messageTitle = ""
    @State private var messageBody = ""

    var body: some View {
        NavigationStack {
            List {
                if gameSettings {
                    //  Settings screen
                    Section("How many questions do you want?") {
                        Picker("Hello", selection: $numberOfQuestions) {
                            ForEach(optionNumberOfQuestions, id: \.self) { option in
                                withAnimation {
                                    Text("\(option)")
                                }
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    Section("Which multiplication table?") {
                        Stepper("\(multiplicationTable)", value: $multiplicationTable, in: 2 ... 12)
                    }

                    HStack {
                        Button("Random multiplication table") {
                            multiplicationTable = Int.random(in: 2 ... 12)
                        }
                    }
                } else {
                    // Game screen
                    Section {
                        ForEach(0 ..< numberOfQuestions, id: \.self) { number in
                            Text("\(number + 1) x \(multiplicationTable) = \((number + 1) * multiplicationTable)")
                        }
                    }
                }
            }
            .navigationTitle("Mutiply Challenge")
            .toolbar(content: {
                if gameSettings {
                    Button("Start") {
                        gameSettings.toggle()
                    }
                } else {
                    Button("Give Up") {
                        giveUp()
                    }

                    Button("Submit") {
                        calculateResults()
                    }
                }
            }
            )
        }
        .alert(messageTitle, isPresented: $gameOver) {
            Button("Play Again") { 
                gameSettings.toggle()
            }
        } message: {
            Text("\n \(messageBody)")
        }
    }

    func calculateResults() {
        userScore = Int.random(in: 0 ... 20)
        messageTitle = "Game Over!"
        messageBody = "Great job!\nYour score is \(userScore)"
        gameOver.toggle()
    }

    func giveUp() {
        messageTitle = "Oh no! 💀"
        messageBody = "Don't worry about it!\nYou can try again anytime."
        gameOver.toggle()
    }
}

#Preview {
    ContentView()
}
