//
//  ViewController.swift
//  project7-9_hungman
//
//  Created by jimi bird on 2022-01-28.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var usedLettersLabel: UILabel!
    
    var hungmanBrain = HungmanBrain()
    
    var hungImage = UIImage(named: "0")
    
    var wrongAnswers = 0 {
        didSet {
            hungImage = UIImage(named: "\(wrongAnswers)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = hungImage
        
        hungmanBrain.startGame()
        wordLabel.text = hungmanBrain.marks
    }
    
    @IBAction func letterButtonTapped(_ sender: UIButton) {
        let btnString = hungmanBrain.letterBits[sender.tag]
        
        // if tapped letter isn't the same
        if !hungmanBrain.usedLetters.contains(btnString) {
            hungmanBrain.usedLetters.append(btnString)
            
            hungmanBrain.letterCheckUp()
            wordLabel.text = hungmanBrain.shownWord
            
            // if letter is nor the letter in the word to guess:
            if !hungmanBrain.lettersToGuess.contains(btnString) {
                wrongAnswers += 1
                let arrayLet = hungmanBrain.usedLetters.map {$0}.compactMap({$0}).joined(separator: " ")
                usedLettersLabel.text = arrayLet.uppercased()
            }
            imageView.image = hungImage
        }
        
        if hungmanBrain.shownWord == hungmanBrain.wordToGuess.uppercased() {
            winGame()
        } else if wrongAnswers == 7 {
            looseGame()
        }
    }
    
    func resetGame() {
        hungmanBrain.startGame()
        wrongAnswers = 0
        imageView.image = hungImage
        wordLabel.text = hungmanBrain.marks
        usedLettersLabel.text = ""
    }
    
    func looseGame() {
        let ac = UIAlertController(title: "GAME OVER", message: "You are a dead", preferredStyle: .alert)
        //        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction(title: "Try another", style: .default, handler: { [weak self] action in
            self?.resetGame()
        }))
        present(ac, animated: true)
    }
    
    func winGame() {
        let ac = UIAlertController(title: "Congratulation", message: "You are alive!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Try another", style: .default, handler: { [weak self] action in
            self?.resetGame()
        }))
        present(ac, animated: true)
    }
}


