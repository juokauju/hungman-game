//
//  HungmanBrain.swift
//  Hungman
//
//  Created by jimi bird on 2022-05-29.
//

import Foundation

struct HungmanBrain {
    var letterBits = [String]()
    var gameWords = [String]()
    var wordToGuess = ""
    var lettersToGuess = [String]()
    var shownWord = ""
    var marks: String = ""
    var usedLetters = [String]()
    var usedWords = [String]()
    
    
    mutating func makeLetters() {
        if let alphabetFileURL = Bundle.main.url(forResource: "alphabet", withExtension: "txt") {
            if let alphabetContents = try? String(contentsOf: alphabetFileURL) {
                let bits = alphabetContents.components(separatedBy: ", ")
                
                letterBits += bits
                print(letterBits)
            }
        }
    }
    
    mutating func loadWords() {
        if let hungmanWordsURL = Bundle.main.url(forResource: "pvz1", withExtension: "txt") {
            if let startWords = try? String(contentsOf: hungmanWordsURL) {
                gameWords = startWords.components(separatedBy: "\n")
                gameWords.removeLast()
                
                print(gameWords)
            }
        }
        
        if gameWords.isEmpty {
            print("slikworm")
        }
    }
    
    mutating func startGame() {
        makeLetters()
        loadWords()
        
        guard gameWords.count > 0 else { return }
        
//        wrongAnswers = 0
        usedLetters.removeAll()
        lettersToGuess.removeAll()

        wordToGuess = gameWords.randomElement()!
        
        marks = String(repeating: "_ ", count: wordToGuess.count)
        
        usedWords.append(wordToGuess)
        if let index = gameWords.firstIndex(of: wordToGuess){
            gameWords.remove(at: index)
        }

        for l in wordToGuess {
            lettersToGuess.append(String(l))
        }
    }
    
    mutating func letterCheckUp() {
        shownWord = ""
        
        for letter in wordToGuess {
            let strLetter = String(letter)
            
            if usedLetters.contains(strLetter) {
                shownWord += strLetter.uppercased()
            } else {
                shownWord += "_ "
            }
            
        }
    }
}
