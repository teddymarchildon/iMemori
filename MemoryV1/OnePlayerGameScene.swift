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
    var highscoreLabel: SKLabelNode!
    var fastestTimeLabel: SKLabelNode!
    var timer = Timer()
    
    override func didMoveToView(view: SKView) {
        if let textLabel = self.childNodeWithName("textLabel") as? SKLabelNode, let scoreLabel = self.childNodeWithName("scoreLabel") as? SKLabelNode, let finishedLabel = self.childNodeWithName("finishedLabel") as? SKLabelNode, let timerLabel = self.childNodeWithName("timerLabel") as? SKLabelNode, let mainMenuLabel = self.childNodeWithName("backToMainLabel") as? SKLabelNode, let highscoreLabel = self.childNodeWithName("highscoreLabel") as? SKLabelNode, let fastestTimeLabel = self.childNodeWithName("fastestTimeLabel") as? SKLabelNode {
            self.textLabel = textLabel
            self.scoreLabel = scoreLabel
            self.finishedLabel = finishedLabel
            self.timerLabel = timerLabel
            self.mainMenuLabel = mainMenuLabel
            self.highscoreLabel = highscoreLabel
            self.highscoreLabel.hidden = true
            self.fastestTimeLabel = fastestTimeLabel
            self.fastestTimeLabel.hidden = true
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
                if let first = game.firstChoice, second = game.secondChoice {
                    let isMatch = game.onePlayerTestMatch()
                    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.3 * Double(NSEC_PER_SEC)))
                    dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                        if isMatch {
                            first.removeFromParent()
                            second.removeFromParent()
                            self.testEndGame()
                        } else {
                            first.flip()
                            second.flip()
                        }
                        self.updateScoreLabel()
                    })
                }
            } else if node == mainMenuLabel {
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .AspectFit
                    self.view?.presentScene(scene, transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 1.0))
                }
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        timerLabel.text = timer.timerString
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(game.score)"
    }
    
    func testEndGame() -> Bool {
        if self.children.count < 8 {
            game.finished = true
            timer.stop()
            finishedLabel.hidden = false
            if let highscore = Records.highscore, fastestTimeInt = Records.fastestTimeInt {
                if game.score > highscore {
                    Records.setHighscore(game.score)
                }
                if timer.totalSeconds < fastestTimeInt {
                    Records.setFastestTime(timer.totalSeconds, newTimeString: timer.finalMinutes + ":" + timer.finalSeconds)
                }
            } else {
                Records.setHighscore(game.score)
                Records.setFastestTime(timer.totalSeconds, newTimeString: timer.finalMinutes + ":" + timer.finalSeconds)
            }
            highscoreLabel.text = "Highscore: \(Records.highscore!)"
            fastestTimeLabel.text = "Fastest Time: \(Records.fastestTimeString!)"
            highscoreLabel.hidden = false
            fastestTimeLabel.hidden = false
            return true
        }
        return false
    }
}
