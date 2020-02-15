//
//  Concentration.swift
//  Concentration
//
//  Created by Peter Bakholdin on 12.02.2020.
//  Copyright © 2020 Peter Bakholdin. All rights reserved.
//

import Foundation

class Concentration {
    
    //var cards: Array<Card> // class 'Concentration' has no initializers
    //var cards = Array<Card>()
    
    var cards = [Card]()
    
    var anotherCardFaceUp: Int?
    
    var flipCount: Int
    var score: Int

    
    func chooseCard(at index: Int) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = anotherCardFaceUp, matchIndex != index  {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[index].hasBeenShowed { score -= 1 }
                }
                anotherCardFaceUp = nil
            } else {
                for indexCardsFaceDown in cards.indices {
                    cards[indexCardsFaceDown].isFaceUp = false
                }
                anotherCardFaceUp = index
            }
            cards[index].hasBeenShowed = true
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        flipCount = 0
        score = 0
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
