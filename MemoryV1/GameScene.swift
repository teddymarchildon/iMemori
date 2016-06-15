//
//  GameScene.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/14/16.
//  Copyright (c) 2016 Teddy Marchildon. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let game = Game()
    
    override func didMoveToView(view: SKView) {
        let cards = game.cardsArray.shuffle()
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
            if node != self {
                if game.firstChoice == nil {
                    let card = node as! Card
                    card.flip()
                    card.faceUp = true
                    game.firstChoice = card
                }
                else if game.secondChoice == nil {
                    let card = node as! Card
                    card.flip()
                    card.faceUp = true
                    game.secondChoice = card
                }
                let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.testEqual()
                }
            }
        }
    }
    
    func testEqual() {
        if let first = game.firstChoice, second = game.secondChoice {
            if first.value == second.value && first.suit == second.suit {
                first.hidden = true
                second.hidden = true
                setNils()
            } else {
                flipBoth(first, card2: second)
                setNils()
            }
        }
    }
    
    func setNils() {
        game.firstChoice = nil
        game.secondChoice = nil
    }
    
    func flipBoth(card1: Card, card2: Card) {
        card1.flip()
        card2.flip()
    }
    
}
