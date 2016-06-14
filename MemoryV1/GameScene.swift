//
//  GameScene.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/14/16.
//  Copyright (c) 2016 Teddy Marchildon. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let cards = Game(numCards: 16).cardsArray
    
    override func didMoveToView(view: SKView) {
        setFirstRows(cards)
        let shuffledCards = cards.shuffle()
        setSecondRows(shuffledCards)
    }
    
    func setFirstRows(cards: [Card]) {
        var positions: CGPoint = CGPoint(x: 135, y: 1680)
        var name = 1
        for num in 0...cards.count - 1 {
            if num == 4 {
                positions.x = 135
                positions.y = 1200
            }
            let card = cards[num]
            let node = SKSpriteNode(texture: card.flipTexture)
            self.addChild(node)
            node.size = CGSize(width: 125.0, height: 200.0)
            node.position = positions
            node.name = "\(name)"
            name += 1
            positions.x += 270
        }
    }
    
    func setSecondRows(cards: [Card]) {
        var positions: CGPoint = CGPoint(x: 135, y: 720)
        var name = cards.count / 2 + 1
        for num in 0...cards.count - 1 {
            if num == 4 {
                positions.x = 135
                positions.y = 240
            }
            let card = cards[num]
            let node = SKSpriteNode(texture: card.flipTexture)
            self.addChild(node)
            node.size = CGSize(width: 125.0, height: 200.0)
            node.position = positions
            node.name = "\(name)"
            name += 1
            positions.x += 270
            
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
