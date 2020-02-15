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
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet var cardButtons: [UIButton]!
    
    let emojiConstChoices = ["👻", "😀", "🎃", "🤖", "🧠", "👯‍♀️", "👚", "👠", "🎓", "💍", "🕶", "🐶", "🦋", "🦐", "🍎"]
    let emojiFaces = ["😀", "😅", "😍", "😎", "🥳", "😡", "🥶", "🤥", "🤢", "😈", "🤠", "💀", "😻" ,"🤖", "💩"]
    
    lazy var emojiChoices = emojiConstChoices
    
    lazy var emojiThemesDict: [String: [String]] = ["General": emojiConstChoices, "Faces": emojiFaces]
    
    lazy var currentTheme = Array(emojiThemesDict.keys).randomElement()
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Button is not in cardButton list")
        }
    }
    
    func updateViewFromModel() {
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
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        currentTheme = Array(emojiThemesDict.keys).randomElement()
        emojiChoices = emojiThemesDict[currentTheme ?? "General"] ?? emojiConstChoices
        
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
    }
    

    //var emoji = Dictionary<Int, String>()
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
