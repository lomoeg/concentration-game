//
//  Card.swift
//  I Am Rich
//
//  Created by Peter Bakholdin on 12.02.2020.
//  Copyright © 2020 Peter Bakholdin. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var hasBeenShowed = false
    private var identifier: Int
    
    private static var uniqueIdentifier = 0
    
    private static func getUniqueIdentifier() -> Int {
        uniqueIdentifier += 1
        return uniqueIdentifier
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
