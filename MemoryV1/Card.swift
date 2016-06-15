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
    
    var faceUp = false
    final let coverTexture = SKTexture(imageNamed: "DukeLogo")
    let suit: Deck.Suit
    let value: Deck.Value
    let flipTexture: SKTexture
    
    convenience init() {
        let suit = Deck.Suit.getRandomSuit()
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
//        userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        flip()
//    }
//    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        
//    }
//    
    func flip() {
        let firstHalfFlip = SKAction.scaleXTo(0.0, duration: 0.2)
        let secondHalfFlip = SKAction.scaleXTo(1.0, duration: 0.2)
        
        setScale(1.0)
        
        if faceUp {
            runAction(firstHalfFlip) {
                self.texture = self.coverTexture
                self.faceUp = false
                self.runAction(secondHalfFlip)
            }
        } else {
            runAction(firstHalfFlip) {
                self.texture = self.flipTexture
                self.faceUp = true
                self.runAction(secondHalfFlip)
            }
        }
    }
}

class Game {
    
    var cardsArray: [Card] = []
    var valueSet = Set<Deck.Value>()
    var firstChoice: Card? = nil
    var secondChoice: Card? = nil
    
    init() {
        while cardsArray.count < 16 / 2 {
            let card = Card()
            if valueSet.count == 13 { valueSet.removeAll() }
            if !valueSet.contains(card.value) {
                valueSet.insert(card.value)
                cardsArray.append(card)
            }
        }
        for card in cardsArray {
            let card1 = Card(cardSuit: card.suit, cardValue: card.value, flipTexture: card.flipTexture)
            cardsArray.append(card1)
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




















