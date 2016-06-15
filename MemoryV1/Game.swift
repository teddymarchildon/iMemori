//
//  Game.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/15/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import Foundation
import SpriteKit

class Game: SKScene {
    
    var cardsArray: [Card] = []
    var valueSet = Set<Deck.Value>()
    var firstChoice: Card? = nil
    var secondChoice: Card? = nil
    
    override func didMoveToView(view: SKView) {
        let cards = self.cardsArray.shuffle()
        setFirstRow(cards)
        setSecondRow(cards)
        setThirdRow(cards)
        setFourthRow(cards)
    }
    
    func setFirstRow(cards: [Card]) {
        var positions: CGPoint = CGPoint(x: 135, y: 1680)
        var name = 0
        for num in 0...3 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: 125.0, height: 200.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 270
            self.addChild(card)
        }
    }
    
    func setSecondRow(cards: [Card]) {
        var positions: CGPoint = CGPoint(x: 135, y: 1200)
        var name = 4
        for num in 4...7 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: 125.0, height: 200.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 270
            self.addChild(card)
        }
    }
    
    func setThirdRow(cards: [Card]) {
        var positions: CGPoint = CGPoint(x: 135, y: 720)
        var name = 8
        for num in 8...11 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: 125.0, height: 200.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 270
            self.addChild(card)
        }
    }
    
    func setFourthRow(cards: [Card]) {
        var positions: CGPoint = CGPoint(x: 135, y: 240)
        var name = 12
        for num in 12...15 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: 125.0, height: 200.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 270
            self.addChild(card)
        }
    }
    override init() {
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
        super.init(size: CGSize())
        userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            print(touches.count)
            if touches.count % 2 != 0 {
                let location = touch.locationInNode(self)
                self.firstChoice = nodeAtPoint(location) as? Card
                flip(self.firstChoice!)
            } else if touches.count % 2 == 0 {
                let location = touch.locationInNode(self)
                self.secondChoice = nodeAtPoint(location) as? Card
                flip(self.secondChoice!)
                if let first = self.firstChoice, let second = self.secondChoice {
                    if first.suit == second.suit && first.value == second.value {
                        first.hidden = true
                        second.hidden = true
                    } else {
                        first.flip()
                        second.flip()
                        self.firstChoice = nil
                        self.secondChoice = nil
                    }
                }
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    func flip(card: Card) {
        let firstHalfFlip = SKAction.scaleXTo(0.0, duration: 0.3)
        let secondHalfFlip = SKAction.scaleXTo(1.0, duration: 0.3)
        
        setScale(1.0)
        
        if card.faceUp {
            runAction(firstHalfFlip) {
                card.texture = card.coverTexture
                card.faceUp = false
                self.runAction(secondHalfFlip)
            }
        } else {
            runAction(firstHalfFlip) {
                card.texture = card.flipTexture
                card.faceUp = true
                card.runAction(secondHalfFlip)
            }
        }
    }
}