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

    @IBOutlet var keyboardView: KeyboardView!
    
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
        let marks = String(repeating: "_ ", count: hungmanBrain.wordToGuess.count)
        wordLabel.text = marks
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
    }
    // Ending could be different
    func looseGame() {
        let ac = UIAlertController(title: "GAME OVER", message: "You are a hanged", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction(title: "Try another", style: .default, handler: { [weak self] action in
            self?.hungmanBrain.startGame()
            self?.wrongAnswers = 0
        }))
        present(ac, animated: true)
    }
    
    func winGame() {
        let ac = UIAlertController(title: "Congratulation", message: "You guessed correctly", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Try another", style: .default, handler: { [weak self] action in
            self?.hungmanBrain.startGame()
            self?.wrongAnswers = 0
        }))
        present(ac, animated: true)
    }
    
}



extension KeyboardView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hungmanBrain.letterBits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LetterButtonCell", for: indexPath) as? LetterButtonCell else {
            fatalError("Unable to dequeue LetterButtonCell.")
        }
        cell.button.setTitle(hungmanBrain.letterBits[indexPath.item], for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let btnString = String(describing: collectionView.cellForItem(at: indexPath))
        hungmanBrain.usedLetters.append(btnString)
        hungmanBrain.letterCheckUp()
        mainView.wordLabel.text = hungmanBrain.shownWord
        
        if !hungmanBrain.lettersToGuess.contains(btnString) {
            mainView.wrongAnswers += 1
               }
        mainView.imageView.image = mainView.hungImage
        
        if hungmanBrain.shownWord == hungmanBrain.wordToGuess.uppercased() {
            mainView.winGame()
        } else if mainView.wrongAnswers == 7 {
            mainView.looseGame()
                }
    }
}
