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
            case .jack: return "jack_of_" + suit.rawValue
            case .queen: return "queen_of_" + suit.rawValue
            case .king: return "king_of_" + suit.rawValue
            case .ace: return "ace_of_" + suit.rawValue
            default: return "\(value.rawValue)" + "_of_" + suit.rawValue
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
    
    enum Value: Int {
        case two = 2
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
    
    var selected: Bool = false
    var faceUp: Bool = false
    final let coverTexture = SKTexture(imageNamed: "NewLightGrayGradient")
    let suit: Deck.Suit
    let value: Deck.Value
    let flipTexture: SKTexture
    
    convenience init() {
        let suit = Deck.Suit.getRandomSuit()
        let value = Deck.Value.getRandomValue()
        let flipString = SKTexture(imageNamed: Deck.getCardTexture(suit, value: value))
        self.init(cardSuit: suit, cardValue: value, flipTexture: flipString)
    }
    
    convenience init(withSuit suit: Deck.Suit) {
        let suit = suit
        let value = Deck.Value.getRandomValue()
        let flipString = SKTexture(imageNamed: Deck.getCardTexture(suit, value: value))
        self.init(cardSuit: suit, cardValue: value, flipTexture: flipString)
    }
    
    init(cardSuit: Deck.Suit, cardValue: Deck.Value, flipTexture: SKTexture) {
        self.suit = cardSuit
        self.value = cardValue
        self.flipTexture = flipTexture
        let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        super.init(texture: coverTexture, color: color, size: coverTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flip() {
        let firstHalfFlip = SKAction.scaleXTo(0.0, duration: 0.1)
        let secondHalfFlip = SKAction.scaleXTo(1.0, duration: 0.1)
        let popUp = SKAction.scaleTo(1.2, duration: 0.1)
        let backDown = SKAction.scaleTo(1.0, duration: 0.1)

        if faceUp {
            runAction(firstHalfFlip) {
                self.texture = self.coverTexture
                self.faceUp = false
                self.runAction(secondHalfFlip)
            }
        } else {
            runAction(SKAction.sequence([popUp, firstHalfFlip])) {
                self.texture = self.flipTexture
                self.faceUp = true
                self.runAction(SKAction.sequence([secondHalfFlip, backDown]))
            }
        }
    }
    
    func isMatch(card: Card) -> Bool {
        return self.value == card.value && self.suit == card.suit
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
