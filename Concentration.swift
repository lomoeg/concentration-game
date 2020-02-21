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
    
    private(set) var cards = [Card]()
    
    private var anotherCardFaceUp: Int? {
        get {
            var foundIndex: Int?
            for i in cards.indices {
                if cards[i].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = i
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for i in cards.indices {
                cards[i].isFaceUp = (i == newValue)
            }
        }
    }
    
    private(set) var flipCount: Int
    private(set) var score: Int

    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "chooseCard(at: \(index)): index is out of range")
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = anotherCardFaceUp, matchIndex != index  {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[index].hasBeenShowed { score -= 1 }
                }
                cards[index].isFaceUp = true
            } else {
//                for indexCardsFaceDown in cards.indices {
//                    cards[indexCardsFaceDown].isFaceUp = false
//                }
                anotherCardFaceUp = index
            }
            cards[index].hasBeenShowed = true
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "numberOfPairsOfCards <= 0")
        flipCount = 0
        score = 0
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
