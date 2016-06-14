//
//  Card.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/14/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import Foundation
import SpriteKit

enum Deck {
    
    static func getCardTexture(suit: Suit, value: Value) -> String {
        var imageString: String {
            switch value {
            case .two: return "2_of_" + suit.rawValue
            case .three: return "3_of_" + suit.rawValue
            case .four: return "4_of_" + suit.rawValue
            case .five: return "5_of_" + suit.rawValue
            case .six: return "6_of_" + suit.rawValue
            case .seven: return "7_of_" + suit.rawValue
            case .eight: return "8_of_" + suit.rawValue
            case .nine: return "9_of_" + suit.rawValue
            case .ten: return "10_of_" + suit.rawValue
            default: return value.rawValue + "_of_" + suit.rawValue
            }
        }
        return imageString
    }
    
    enum Suit: String {
        case hearts
        case clubs
        case spades
        case diamonds
        
        static func getRandomSuit() -> Suit {
            let poss: [Suit] = [.hearts, .clubs, .spades, .diamonds]
            let randomNumber = Int(arc4random_uniform(UInt32(poss.count - 1)))
            return poss[randomNumber]
        }
    }
    
    enum Value: String {
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case ten
        case jack
        case queen
        case king
        case ace
        
        static func getRandomValue() -> Value {
            let poss: [Value] = [.two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king, .ace]
            let randomNumber = Int(arc4random_uniform(UInt32(poss.count - 1)))
            return poss[randomNumber]
        }
    }
}

class Card: SKSpriteNode {
    
    final let coverTexture = SKTexture(imageNamed: "DukeLogo")
    let suit: Deck.Suit
    let value: Deck.Value
    let flipTexture: SKTexture
    
    convenience init() {
        let suit = Deck.Suit.getRandomSuit()
        let value = Deck.Value.getRandomValue()
        let flipString = Deck.getCardTexture(suit, value: value)
        self.init(cardSuit: suit, cardValue: value, flipString: flipString)
    }
    
    init(cardSuit: Deck.Suit, cardValue: Deck.Value, flipString: String) {
        self.suit = cardSuit
        self.value = cardValue
        self.flipTexture = SKTexture(imageNamed: flipString)
        let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        super.init(texture: coverTexture, color: color, size: coverTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Game {
    
    var cardsArray: [Card] = []
    var suitSet = Set<Deck.Suit>()
    var valueSet = Set<Deck.Value>()
    
    init(numCards: Int) {
        while cardsArray.count < numCards / 2 {
            let card = Card()
            if suitSet.count == 4 { suitSet.removeAll() }
            if valueSet.count == 13 { valueSet.removeAll() }
            if !valueSet.contains(card.value) {
                valueSet.insert(card.value)
                cardsArray.append(card)
            }
        }
    }
}

extension Array {
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    mutating func shuffleInPlace() {
        if count < 2 { return }
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}




















