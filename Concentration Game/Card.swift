//
//  Card.swift
//  I Am Rich
//
//  Created by Peter Bakholdin on 12.02.2020.
//  Copyright © 2020 Peter Bakholdin. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var hasBeenShowed = false
    var identifier: Int
    
    static var uniqueIdentifier = 0
    
    static func getUniqueIdentifier() -> Int {
        uniqueIdentifier += 1
        return uniqueIdentifier
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
