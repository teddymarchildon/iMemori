//
//  TwoPlayerGameScene.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/16/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import SpriteKit

class TwoPlayerGameScene: SKScene {
    
    let game = Game()
    var cards: [Card] = []
    var playerOneLabel: SKLabelNode!
    var playerTwoLabel: SKLabelNode!
    var playerOneScoreLabel: SKLabelNode!
    var playerTwoScoreLabel: SKLabelNode!
    var winnerLabel: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        game.playerOneTurn = true
        game.playerTwoTurn = false
        game.playerOneScore = 0
        game.playerTwoScore = 0
        if let playerOneScoreLabel = self.childNodeWithName("playerOneScoreLabel") as? SKLabelNode, let playerTwoScoreLabel = self.childNodeWithName("playerTwoScoreLabel") as? SKLabelNode, let playerOneLabel = self.childNodeWithName("playerOneScore") as? SKLabelNode, let playerTwoLabel = self.childNodeWithName("playerTwoScore") as? SKLabelNode, let winnerLabel = self.childNodeWithName("winnerLabel") as? SKLabelNode {
            self.playerOneScoreLabel = playerOneScoreLabel
            self.playerTwoScoreLabel = playerTwoScoreLabel
            self.playerOneLabel = playerOneLabel
            self.playerOneLabel.fontColor = UIColor.blueColor()
            self.playerTwoLabel = playerTwoLabel
            self.winnerLabel = winnerLabel
            self.winnerLabel.hidden = true
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
                    let delay = 1.5 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                        self.testMatch()
                    })
                    //  NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(testMatch), userInfo: nil, repeats: false)
                }
            }
        }
    }
    
    func testMatch() {
        if let first = game.firstChoice, second = game.secondChoice {
            if first.isMatch(second) {
                first.removeFromParent()
                second.removeFromParent()
                if game.playerOneTurn! {
                    game.playerOneScore! += 100
                } else {
                    game.playerTwoScore! += 100
                }
                updateScoreLabels()
                reset()
            } else {
                if game.playerOneTurn! {
                    game.playerOneScore! -= 20
                } else {
                    game.playerTwoScore! -= 20
                }
                updateScoreLabels()
                flipBoth(first, card2: second)
                reset()
            }
        }
    }
    
    func updateScoreLabels() {
        if game.playerOneTurn! {
            playerOneScoreLabel.text = "\(game.playerOneScore!)"
            game.playerOneTurn = false
            game.playerTwoTurn = true
            playerTwoLabel.fontColor = .blueColor()
            playerOneLabel.fontColor = .whiteColor()
        } else {
            playerTwoScoreLabel.text = "\(game.playerTwoScore!)"
            game.playerTwoTurn = false
            game.playerOneTurn = true
            playerOneLabel.fontColor = .blueColor()
            playerTwoLabel.fontColor = .whiteColor()
        }
    }
    
    func reset() {
        if self.children.count < 7 {
            game.finished = true
            if game.playerOneScore > game.playerTwoScore { winnerLabel.text = "Player 1 won!" }
            else if game.playerTwoScore > game.playerOneScore { winnerLabel.text = "Player 2 won!" }
            else { winnerLabel.text = "Tie!" }
            winnerLabel.hidden = false
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

