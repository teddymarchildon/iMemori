//
//  GameScene.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/14/16.
//  Copyright (c) 2016 Teddy Marchildon. All rights reserved.
//

import SpriteKit

class OnePlayerGameScene: SKScene {
    
    var game = Game()
    var cards: [SKSpriteNode] = []
    var textLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var finishedLabel: SKLabelNode!
    var timerLabel: SKLabelNode!
    var mainMenuLabel: SKLabelNode!
    var timer = Timer()
    
    override func didMoveToView(view: SKView) {
        if let textLabel = self.childNodeWithName("textLabel") as? SKLabelNode, let scoreLabel = self.childNodeWithName("scoreLabel") as? SKLabelNode, let finishedLabel = self.childNodeWithName("finishedLabel") as? SKLabelNode, let timerLabel = self.childNodeWithName("timerLabel") as? SKLabelNode, let mainMenuLabel = self.childNodeWithName("backToMainLabel") as? SKLabelNode {
            self.textLabel = textLabel
            self.scoreLabel = scoreLabel
            self.finishedLabel = finishedLabel
            self.timerLabel = timerLabel
            self.mainMenuLabel = mainMenuLabel
            timerLabel.text = timer.timerString
            finishedLabel.hidden = true
        }
        for card in cards {
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
            if let card = node as? Card {
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
//                    let delay = 1.5 * Double(NSEC_PER_SEC)
//                    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//                    dispatch_after(dispatchTime, dispatch_get_main_queue(), {
//                        self.testMatch()
//                    })
                    NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(testMatch), userInfo: nil, repeats: false)
                }
            } else if node == mainMenuLabel {
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .AspectFit
                    self.view?.presentScene(scene, transition: SKTransition.flipHorizontalWithDuration(1.5))
                }
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        timerLabel.text = timer.timerString
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
    
    func reset() {
        if self.children.count < 7 {
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
