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

    @IBOutlet var letterRows: UIStackView!
    @IBOutlet var letterLine1: UIStackView!
    @IBOutlet var letterLine2: UIStackView!
    @IBOutlet var letterLine3: UIStackView!
    
    
    var letterButtons = [UIButton]()

    
    var allWords = [String]()
    var wordToGuess = ""
    var lettersToGuess = [String]()
    var promtWord = ""
    var usedLetters = [String]()
    var usedWords = [String]()
    
    var hungImage = UIImage(named: "0")
    
    
    
    var wrongAnswers = 0 {
        didSet {
            hungImage = UIImage(named: "\(wrongAnswers)")
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
           print("nutton tapped")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        imageView.image = hungImage
//        NSLayoutConstraint.activate([
//            wordLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 150),
//            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            currentAnswer.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 50),
//            currentAnswer.centerXAnchor.constraint(equalTo: wordLabel.centerXAnchor),
//            currentAnswer.heightAnchor.constraint(equalToConstant: 44),
//            submitButton.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 20),
//            submitButton.centerXAnchor.constraint(equalTo: currentAnswer.centerXAnchor),
//            submitButton.heightAnchor.constraint(equalToConstant: 44)
//            ])
        
        loadWords()
        createLetterButtons()
        startGame()
    }
    
    func loadWords() {
        if let hungmanWordsURL = Bundle.main.url(forResource: "pvz1", withExtension: "txt") {
            if let startWords = try? String(contentsOf: hungmanWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
                
                print(allWords)
            }
        }
        
        if allWords.isEmpty {
            print("slikworm")
        }
        

    }
    
    func createLetterButtons() {
        var letterBits = [String]()
        
        let column1 = 0..<10
        let column2 = 0..<9
        let column3 = 0..<7
        
        // Creating three rows with different button amount
        for col1 in column1 {
            createButton(column: col1, row: 1)
            // Trying to put every button in stack view to have them seperatly
            // Unfortunally it does not work
            // Have to think of something else
            for i in letterButtons {
                
                letterLine1.distribution = .fillEqually
                letterLine1.addSubview(i)
            }
        }
        for col2 in column2 {
            createButton(column: col2, row: 2)
        }
        for col3 in column3 {
            createButton(column: col3, row: 3)
        }
        
        if let alphabetFileURL = Bundle.main.url(forResource: "alphabet", withExtension: "txt") {
            if let alphabetContents = try? String(contentsOf: alphabetFileURL) {
                let bits = alphabetContents.components(separatedBy: ", ")
                print(bits)
                letterBits += bits
            }
        }
        
        // Giving every button a letter
        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterButtons.count {
                letterButtons[i].setTitle(letterBits[i].uppercased(), for: .normal)
            }
        }
    }
    
    func createButton(column: Int, row: Int) {
        
        let width = 30
        let height = 30
        
        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        letterButton.titleLabel?.textColor = .black
        
        let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
        
        letterButton.frame = frame
        letterButton.backgroundColor = .green
        
        //        lettersView.addSubview(letterButton)
        //        letterRows.addSubview(letterButton)
        
        letterButtons.append(letterButton)
        
        letterButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
      
    }
    
    func startGame() {
        guard allWords.count > 0 else { return }
        
        wrongAnswers = 0
        usedLetters.removeAll()
        lettersToGuess.removeAll()

        wordToGuess = allWords.randomElement()!
        
        usedWords.append(wordToGuess)
        if let index = allWords.firstIndex(of: wordToGuess){
            allWords.remove(at: index)
        }

        let marks = String(repeating: "_ ", count: wordToGuess.count)
        wordLabel.text = marks
        
        for l in wordToGuess.uppercased() {
            lettersToGuess.append(String(l))
        }
        
    }

    @IBAction func submitButton(_ sender: Any) {
        // Could be replaced with func for letter button tapped
        
//        guard let answerText = currentAnswer.text else { return }
//
//        currentAnswer.text?.removeAll()
        
//
//        usedLetters.append(answerText.uppercased())
//
//        letterCheckUp()
//        wordLabel.text = promtWord
//
//        if !lettersToGuess.contains(answerText.uppercased()) {
//           wrongAnswers += 1
//        }
//        imageView.image = hungImage
//
//        if promtWord == wordToGuess.uppercased() {
//            winGame()
//        } else if wrongAnswers == 7 {
//            looseGame()
//        }
//
       
    }
    
    func letterCheckUp() {
        promtWord = ""
        
        for letter in wordToGuess.uppercased() {
            let strLetter = String(letter)
            
            if usedLetters.contains(strLetter) {
                promtWord += strLetter
            } else {
                promtWord += "_ "
            }
            
        }
    }
    
    // Ending could be different
    
    func looseGame() {
        let ac = UIAlertController(title: "GAME OVER", message: "You are a hanged", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction(title: "Try another", style: .default, handler: { [weak self] action in
            self?.startGame()
        }))
        present(ac, animated: true)
    }
    
    func winGame() {
        let ac = UIAlertController(title: "Congratulation", message: "You guessed correctly", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Try another", style: .default, handler: { [weak self] action in
            self?.startGame()
        }))
        present(ac, animated: true)
    }
    
}


