//
//  TwoPlayerGameScene.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/16/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import SpriteKit

class TwoPlayerGameScene: SKScene {
    
    var game = Game()
    var cards: [SKSpriteNode] = []
    var playerOneLabel: SKLabelNode!
    var playerTwoLabel: SKLabelNode!
    var playerOneScoreLabel: SKLabelNode!
    var playerTwoScoreLabel: SKLabelNode!
    var mainMenuLabel: SKLabelNode!
    var winnerLabel: SKLabelNode!
    var playerOneMultiplierLabel: SKLabelNode!
    var playerTwoMultiplierLabel: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        game.playerOneTurn = true
        game.playerTwoTurn = false
        game.playerOneScore = 0
        game.playerTwoScore = 0
        game.playerOneMultiplier = 1
        game.playerTwoMultiplier = 1
        if let playerOneScoreLabel = self.childNodeWithName("playerOneScoreLabel") as? SKLabelNode, let playerTwoScoreLabel = self.childNodeWithName("playerTwoScoreLabel") as? SKLabelNode, let playerOneLabel = self.childNodeWithName("playerOneScore") as? SKLabelNode, let playerTwoLabel = self.childNodeWithName("playerTwoScore") as? SKLabelNode, let winnerLabel = self.childNodeWithName("winnerLabel") as? SKLabelNode, let mainMenuLabel = self.childNodeWithName("backToMainLabel") as? SKLabelNode, playerOneMultiplierLabel = self.childNodeWithName("playerOneMultiplierLabel") as? SKLabelNode, playerTwoMultiplierLabel = self.childNodeWithName("playerTwoMultiplierLabel") as? SKLabelNode {
            self.playerOneScoreLabel = playerOneScoreLabel
            self.playerTwoScoreLabel = playerTwoScoreLabel
            self.playerOneLabel = playerOneLabel
            self.playerOneLabel.fontColor = .blackColor()
            self.playerTwoLabel = playerTwoLabel
            self.winnerLabel = winnerLabel
            self.winnerLabel.hidden = true
            self.mainMenuLabel = mainMenuLabel
            self.playerOneMultiplierLabel = playerOneMultiplierLabel
            self.playerTwoMultiplierLabel = playerTwoMultiplierLabel
            self.playerOneMultiplierLabel.text = "\(game.playerOneMultiplier!)x"
            self.playerTwoMultiplierLabel.text = "\(game.playerTwoMultiplier!)x"
        }
        for card in cards {
            self.addChild(card)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
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
                    let bool = game.twoPlayerTestMatch()
                    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.1 * Double(NSEC_PER_SEC)))
                    dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                        if bool {
                            first.removeFromParent()
                            second.removeFromParent()
                        } else {
                            self.flipBoth(first, card2: second)
                        }
                        self.updateScoreLabels()
                        self.testEndGame()
                    })
                }
            } else if node == mainMenuLabel {
                mainMenuLabel.fontColor = .lightGrayColor()
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .AspectFit
                    self.view?.presentScene(scene, transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5))
                }
            }
        }
    }
    
    func updateScoreLabels() {
        if !game.playerOneTurn!{
            playerOneScoreLabel.text = "\(game.playerOneScore!)"
            playerTwoLabel.fontColor = .blackColor()
            playerOneLabel.fontColor = .whiteColor()
            self.playerOneMultiplierLabel.text = "\(game.playerOneMultiplier!)x"
        } else {
            playerTwoScoreLabel.text = "\(game.playerTwoScore!)"
            playerOneLabel.fontColor = .blackColor()
            playerTwoLabel.fontColor = .whiteColor()
            self.playerTwoMultiplierLabel.text = "\(game.playerTwoMultiplier!)x"
        }
    }
    
    func testEndGame() {
        if self.children.count < 9 {
            game.finished = true
            if game.playerOneScore > game.playerTwoScore {
                winnerLabel.text = "Player 1 won!"
                playerOneLabel.fontColor = .greenColor()
                playerTwoLabel.fontColor = .whiteColor()
            } else if game.playerTwoScore > game.playerOneScore {
                winnerLabel.text = "Player 2 won!"
                playerOneLabel.fontColor = .whiteColor()
                playerTwoLabel.fontColor = .greenColor()
            } else {
                winnerLabel.text = "Tie!"
                playerOneLabel.fontColor = .whiteColor()
                playerTwoLabel.fontColor = .whiteColor()
            }
            winnerLabel.hidden = false
        }
    }
    
    func flipBoth(card1: Card, card2: Card) {
        card1.flip()
        card2.flip()
    }
}

