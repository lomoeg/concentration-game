//
//  ViewController.swift
//  Concentration
//
//  Created by Peter Bakholdin on 08.02.2020.
//  Copyright © 2020 Peter Bakholdin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    private var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private let emojiConstChoices = ["👻", "😀", "🎃", "🤖", "🧠", "👯‍♀️", "👚", "👠", "🎓", "💍", "🕶", "🐶", "🦋", "🦐", "🍎"]
    private let emojiFaces = ["😀", "😅", "😍", "😎", "🥳", "😡", "🥶", "🤥", "🤢", "😈", "🤠", "💀", "😻" ,"🤖", "💩"]
    
    //private let emojiFaces = "😀😅😍😎🥳😡🥶🤥🤢😈🤠💀😻🤖💩"
    
    private lazy var emojiChoices = emojiConstChoices
    
    private lazy var emojiThemesDict: [String: [String]] = ["General": emojiConstChoices, "Faces": emojiFaces]
    
    private lazy var currentTheme = Array(emojiThemesDict.keys).randomElement()
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Button is not in cardButton list")
        }
    }
    
    private func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        for i in cardButtons.indices {
            let card = game.cards[i]
            let button = cardButtons[i]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else { 
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0) : #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            }
        }
    }
    
    @IBAction private func touchNewGame(_ sender: UIButton) {
        currentTheme = Array(emojiThemesDict.keys).randomElement()
        emojiChoices = emojiThemesDict[currentTheme ?? "General"] ?? emojiConstChoices
        
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
    }
    

    //var emoji = Dictionary<Int, String>()
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0 
        }
    }
}
