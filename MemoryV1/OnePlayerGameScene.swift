//
//  GameScene.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/14/16.
//  Copyright (c) 2016 Teddy Marchildon. All rights reserved.
//

import SpriteKit

class OnePlayerGameScene: SKScene {
    
    let game = Game()
    var cards: [Card] = []
    var textLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var finishedLabel: SKLabelNode!
    var timerLabel: SKLabelNode!
    var timer = Timer()
    
    override func didMoveToView(view: SKView) {
        if let textLabel = self.childNodeWithName("textLabel") as? SKLabelNode, let scoreLabel = self.childNodeWithName("scoreLabel") as? SKLabelNode, let finishedLabel = self.childNodeWithName("finishedLabel") as? SKLabelNode, let timerLabel = self.childNodeWithName("timerLabel") as? SKLabelNode {
            self.textLabel = textLabel
            self.scoreLabel = scoreLabel
            self.finishedLabel = finishedLabel
            self.timerLabel = timerLabel
            timerLabel.text = timer.timerString
            finishedLabel.hidden = true
        }
        self.cards = game.cardsArray.shuffle()
        setFirstRow(cards)
        setSecondRow(cards)
        setThirdRow(cards)
        setFourthRow(cards)
    }
    
    func setFirstRow(cards: [Card]) {
        var positions: CGPoint = CGPoint(x: 155, y: 1250)
        var name = 0
        for num in 0...3 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: 180.0, height: 240.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 250
            self.addChild(card)
        }
    }
    
    func setSecondRow(cards: [Card]) {
        var positions: CGPoint = CGPoint(x: 155, y: 920)
        var name = 4
        for num in 4...7 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: 180.0, height: 240.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 250
            self.addChild(card)
        }
    }
    
    func setThirdRow(cards: [Card]) {
        var positions: CGPoint = CGPoint(x: 155, y: 600)
        var name = 8
        for num in 8...11 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: 180.0, height: 240.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 250
            self.addChild(card)
        }
    }
    
    func setFourthRow(cards: [Card]) {
        var positions: CGPoint = CGPoint(x: 155, y: 240)
        var name = 12
        for num in 12...15 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: 180.0, height: 240.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 250
            self.addChild(card)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if timer.off {
            timer.start()
            timer.off = false
        }
        for touch in touches {
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
            if node != self {
                let card = node as! Card
                if game.firstChoice == nil {
                    card.selected = true
                    card.flip()
                    card.faceUp = true
                    game.firstChoice = card
                }
                else if game.secondChoice == nil && !card.selected {
                    card.flip()
                    card.faceUp = true
                    game.secondChoice = card
                }
                if game.secondChoice != nil && game.firstChoice != nil {
//                let delay = 1.5 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
//                let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//                dispatch_after(dispatchTime, dispatch_get_main_queue(), {
//                    self.testMatch()
//                })
                    NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(testMatch), userInfo: nil, repeats: false)
                }
            }
        }
    }
    
    func testMatch() {
        if let first = game.firstChoice, second = game.secondChoice {
            if first.isMatch(second) {
                first.removeFromParent()
                second.removeFromParent()
                game.score += 100
                updateScoreLabel()
                reset()
            } else {
                game.score -= 20
                updateScoreLabel()
                flipBoth(first, card2: second)
                reset()
            }
        }
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(game.score)"
    }
    
    override func update(currentTime: NSTimeInterval) {
        timerLabel.text = timer.timerString
    }
    
    func reset() {
        if self.children.count < 5 {
            game.finished = true
            finishedLabel.hidden = false
            timer.stop()
        }
        game.firstChoice?.selected = false
        game.secondChoice?.selected = false
        game.firstChoice = nil
        game.secondChoice = nil
    }
    
    func flipBoth(card1: Card, card2: Card) {
        card1.flip()
        card2.flip()
    }
}
