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
    var backToMainLabel: SKLabelNode!
    var backToMainSprite: SKSpriteNode!
    var highscoreLabel: SKLabelNode!
    var fastestTimeLabel: SKLabelNode!
    var multiplierLabel: SKLabelNode!
    var timer = Timer()
    var playAgainSprite: SKSpriteNode!
    var playAgainLabel: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        if let textLabel = self.childNodeWithName("textLabel") as? SKLabelNode, let scoreLabel = self.childNodeWithName("scoreLabel") as? SKLabelNode, let finishedLabel = self.childNodeWithName("finishedLabel") as? SKLabelNode, let timerLabel = self.childNodeWithName("timerLabel") as? SKLabelNode, let highscoreLabel = self.childNodeWithName("highscoreLabel") as? SKLabelNode, let fastestTimeLabel = self.childNodeWithName("fastestTimeLabel") as? SKLabelNode, let multiplierLabel = self.childNodeWithName("multiplierLabel") as? SKLabelNode, playAgainSprite = self.childNodeWithName("playAgainSprite") as? SKSpriteNode, backToMainSprite = self.childNodeWithName("backToMainSprite") as? SKSpriteNode {
            self.textLabel = textLabel
            self.scoreLabel = scoreLabel
            self.finishedLabel = finishedLabel
            self.timerLabel = timerLabel
            self.highscoreLabel = highscoreLabel
            self.highscoreLabel.hidden = true
            self.fastestTimeLabel = fastestTimeLabel
            self.fastestTimeLabel.hidden = true
            self.multiplierLabel = multiplierLabel
            self.playAgainSprite = playAgainSprite
            self.backToMainSprite = backToMainSprite
            multiplierLabel.text = "\(game.multiplier)x"
            timerLabel.text = timer.timerString
            finishedLabel.hidden = true
            playAgainSprite.hidden = true
        }
        if let playAgainLabel = playAgainSprite.childNodeWithName("playAgainLabel") as? SKLabelNode, backToMainLabel = backToMainSprite.childNodeWithName("backToMainLabel") as? SKLabelNode {
            self.playAgainLabel = playAgainLabel
            self.backToMainLabel = backToMainLabel
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
                    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.1 * Double(NSEC_PER_SEC)))
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
            } else if node == backToMainSprite || node == backToMainLabel {
                backToMainLabel.fontColor = .lightGrayColor()
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .AspectFit
                    self.view?.presentScene(scene, transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5))
                }
            } else if node == playAgainSprite || node == playAgainLabel {
                playAgainLabel.fontColor = .lightGrayColor()
                if let scene = OnePlayerGameScene(fileNamed: "OnePlayerGameScene") {
                    scene.scaleMode = .AspectFit
                    if game.difficulty == .Hard {
                        let cardsAndGame = LoadDataHard.setUp()
                        scene.cards = cardsAndGame.0
                        scene.game = cardsAndGame.1
                        self.view?.presentScene(scene)
                    } else {
                        let cardsAndGame = LoadDataRegular.setUp()
                        scene.cards = cardsAndGame.0
                        scene.game = cardsAndGame.1
                        self.view?.presentScene(scene)
                    }
                }
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        timerLabel.text = timer.timerString
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(game.score)"
        multiplierLabel.text = "\(game.multiplier)x"
    }
    
    func testEndGame() -> Bool {
        if game.difficulty == .Regular {
            if self.children.count < 10 {
                game.finished = true
                timer.stop()
                finishedLabel.hidden = false
                playAgainSprite.hidden = false
                if let highscore = Records.regularHighscore, fastestTimeInt = Records.regularFastestTimeInt {
                    if game.score > highscore {
                        Records.setRegularHighscore(game.score)
                    }
                    if timer.totalSeconds < fastestTimeInt {
                        Records.setRegularFastestTime(timer.totalSeconds, newTimeString: timer.finalMinutes + ":" + timer.finalSeconds)
                    }
                } else {
                    Records.setRegularHighscore(game.score)
                    Records.setRegularFastestTime(timer.totalSeconds, newTimeString: timer.finalMinutes + ":" + timer.finalSeconds)
                }
                highscoreLabel.text = "Regular Highscore: \(Records.regularHighscore!)"
                fastestTimeLabel.text = "Regular Fastest Time: \(Records.regularFastestTimeString!)"
                highscoreLabel.hidden = false
                fastestTimeLabel.hidden = false
                return true
            } else { return false }
        } else {
            if self.children.count < 10 {
                game.finished = true
                timer.stop()
                finishedLabel.hidden = false
                playAgainSprite.hidden = false
                if let highscore = Records.hardHighscore, fastestTimeInt = Records.hardFastestTimeInt {
                    if game.score > highscore {
                        Records.setHardHighscore(game.score)
                    }
                    if timer.totalSeconds < fastestTimeInt {
                        Records.setHardFastestTime(timer.totalSeconds, newTimeString: timer.finalMinutes + ":" + timer.finalSeconds)
                    }
                } else {
                    Records.setHardHighscore(game.score)
                    Records.setHardFastestTime(timer.totalSeconds, newTimeString: timer.finalMinutes + ":" + timer.finalSeconds)
                }
                highscoreLabel.text = "Hard Highscore: \(Records.hardHighscore!)"
                fastestTimeLabel.text = "Hard Fastest Time: \(Records.hardFastestTimeString!)"
                highscoreLabel.hidden = false
                fastestTimeLabel.hidden = false
                return true
            } else { return false }
        }
    }
}