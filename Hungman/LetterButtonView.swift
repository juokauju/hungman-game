//
//  LetterButtonViewController.swift
//  Hungman
//
//  Created by jimi bird on 2022-05-24.
//

import UIKit

class LetterButtonView: UIView {
    
    var letterButtons = [UIButton]()
    var letterBits = [String]()
    var buttonAction: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeButtons()
    }
    
    func makeButtons() {
        
        makeLetters()
        
        let width = 24
        let height = 20
        
        let columns = [10, 9, 7]
        
        for row in 0..<4 {
            for col in columns {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                letterButton.titleLabel?.textColor = .black
                
                if letterBits.count == letterButtons.count {
                    for i in 0 ..< letterButtons.count {
                        letterButtons[i].setTitle(letterBits[i], for: .normal)
                    }
                }
                
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                letterButton.backgroundColor = .green
                
                letterButtons.append(letterButton)
                
                letterButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            }
            
            }
        }
    
    func makeLetters() {
        if let alphabetFileURL = Bundle.main.url(forResource: "alphabet", withExtension: "txt") {
            if let alphabetContents = try? String(contentsOf: alphabetFileURL) {
                let bits = alphabetContents.components(separatedBy: ",/n")
                
                letterBits += bits
            }
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
           if let buttonAction = self.buttonAction {
               buttonAction()
           }
    }
}

// in view controller:
//         letterButtonView.buttonAction = { [weak self] in
//          print("button tapped")
//}
