//
//  GameScene.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/14/16.
//  Copyright (c) 2016 Teddy Marchildon. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        let cards = Game(numCards: 16).cardsArray.shuffle()
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
}
