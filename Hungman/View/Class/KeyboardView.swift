//
//  LetterButtonViewController.swift
//  Hungman
//
//  Created by jimi bird on 2022-05-24.
//

import UIKit

//@IBDesignable
class KeyboardView: UIView, UICollectionViewDelegate {

    @IBOutlet var contentView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    var hungmanBrain = HungmanBrain()
    let mainView = ViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        UINib(nibName: "KeyboardView", bundle: nil).instantiate(withOwner: self, options: nil)
        commonInit()
    }
    
    
    private func commonInit() {
            let bundle = Bundle(for: type(of: self))
            bundle.loadNibNamed("KeyboardView", owner: self, options: nil)
            addSubview(contentView)
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.backgroundColor = .red
            initCollectionView()
        }
        
        private func initCollectionView() {
            let nib = UINib(nibName: "LetterButtonCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "LetterButtonCell")
            collectionView.dataSource = self
        }
    

}
    
//    func makeLetters() {
//        if let alphabetFileURL = Bundle.main.url(forResource: "alphabet", withExtension: "txt") {
//            if let alphabetContents = try? String(contentsOf: alphabetFileURL) {
//                let bits = alphabetContents.components(separatedBy: ",/n")
//
//                letterBits += bits
//            }
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        //            letterButtons.count
//        26
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LetterButtonCell", for: indexPath) as? LetterButtonCell else {
//            fatalError("Unable to dequeue LetterButtonCell.")
//        }
//        cell.button.setTitle(letterBits[indexPath.item], for: .normal)
//        return cell
//    }
    


    
//extension KeyboardView: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        //            letterButtons.count
//        26
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LetterButtonCell", for: indexPath) as? LetterButtonCell else {
//            fatalError("Unable to dequeue LetterButtonCell.")
//        }
//        cell.button.setTitle(letterBits[indexPath.item], for: .normal)
//        return cell
//    }
//}


//    func initialize() {
//        KeyboardView.initialize()
//
//            // first: load the view hierarchy to get proper outlets
//            let name = String(describing: type(of: self))
//            let nib = UINib(nibName: name, bundle: .main)
//            nib.instantiate(withOwner: self, options: nil)
//
//            // next: append the container to our view
//            self.addSubview(self.contentView)
//            self.contentView.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
//                self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//                self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//                self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            ])
//        }
//
//    private func initCollectionView() {
//      let nib = UINib(nibName: "LetterButtonCell", bundle: nil)
//      collectionView.register(nib, forCellWithReuseIdentifier: "LetterButtonCell")
//      collectionView.dataSource = self
//    }
    
//    override func awakeFromNib() {
//        Bundle.main.loadNibNamed("KeyboardView", owner: self, options: nil)
//        addSubview(contentView)
//        contentView.frame = bounds
//        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        letterButtons.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LetterButtonCell", for: indexPath) as? LetterButtonCell else {
//            fatalError("Unable to dequeue LetterButtonCell.")
//        }
//        cell.button.setTitle(letterBits[indexPath.item], for: .normal)
//        return cell
//    }
    

    
//    func makeButtons() {
//
//        makeLetters()
//
//        let width = 24
//        let height = 20
//
//        let columns = [10, 9, 7]
//
//        for row in 0..<4 {
//            for col in columns {
//                let letterButton = UIButton(type: .system)
//                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
//                letterButton.titleLabel?.textColor = .black
//
//                if letterBits.count == letterButtons.count {
//                    for i in 0 ..< letterButtons.count {
//                        letterButtons[i].setTitle(letterBits[i], for: .normal)
//                    }
//                }
//
//                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
//                letterButton.frame = frame
//                letterButton.backgroundColor = .green
//
//                letterButtons.append(letterButton)
//
//                letterButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//            }
//
//            }
//        }
//@objc func buttonTapped(_ sender: UIButton) {
//       if let buttonAction = self.buttonAction {
//           buttonAction()
//       }
//}
// in view controller:
//         letterButtonView.buttonAction = { [weak self] in
//          print("button tapped")
//}
