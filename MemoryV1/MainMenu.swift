//
//  MainMenu.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/17/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    
    var mainLabel: SKLabelNode!
    var onePlayerMode: SKSpriteNode!
    var twoPlayerMode: SKSpriteNode!
    var toRecordScene: SKSpriteNode!
    var onePlayerLabel: SKLabelNode!
    var twoPlayerLabel: SKLabelNode!
    var recordLabel: SKLabelNode!
    var cards: [SKSpriteNode] = []
    var game: Game? = nil
    var onePlayerScene: AnyObject? = nil
    var twoPlayerScene: AnyObject? = nil
    var recordScene: AnyObject? = nil
    var pressed: SKAction = SKAction.scaleTo(1.2, duration: 0.5)
    
    override func didMoveToView(view: SKView) {
        (self.cards, self.game) = LoadData.setUp()
        if let mainLabel = self.childNodeWithName("mainLabel") as? SKLabelNode, let onePlayerMode = self.childNodeWithName("onePlayerButtonSprite") as? SKSpriteNode, let twoPlayerMode = self.childNodeWithName("twoPlayerButtonSprite") as? SKSpriteNode, let toRecordLabel = self.childNodeWithName("recordsButtonSprite") as? SKSpriteNode {
            self.mainLabel = mainLabel
            self.onePlayerMode = onePlayerMode
            self.twoPlayerMode = twoPlayerMode
            self.toRecordScene = toRecordLabel
            if let onePlayerLabel = onePlayerMode.childNodeWithName("onePlayerLabel") as? SKLabelNode, let twoPlayerLabel = twoPlayerMode.childNodeWithName("twoPlayerLabel") as? SKLabelNode, let recordLabel = toRecordScene.childNodeWithName("recordsLabel") as? SKLabelNode {
                self.onePlayerLabel = onePlayerLabel
                self.twoPlayerLabel = twoPlayerLabel
                self.recordLabel = recordLabel
            }
        }
        
        if let scene1 = OnePlayerGameScene(fileNamed:"OnePlayerGameScene") {
            scene1.scaleMode = .AspectFit
            scene1.cards = cards
            scene1.game = game!
            self.onePlayerScene = scene1 as SKScene
        }
        
        if let scene2 = TwoPlayerGameScene(fileNamed:"TwoPlayerGameScene") {
            scene2.scaleMode = .AspectFit
            scene2.cards = cards
            scene2.game = game!
            self.twoPlayerScene = scene2 as SKScene
        }
        
        if let recordScene = HighscoresScene(fileNamed: "HighscoresScene") {
            recordScene.scaleMode = .AspectFit
            self.recordScene = recordScene as SKScene
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
            if node == onePlayerMode || node == onePlayerLabel {
                onePlayerLabel.fontColor = .lightGrayColor()
                self.view?.presentScene((onePlayerScene as? SKScene)!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5))
            } else if node == twoPlayerMode || node == twoPlayerLabel {
                twoPlayerLabel.fontColor = .lightGrayColor()
                self.view?.presentScene((twoPlayerScene as? SKScene)!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5))
            } else if node == toRecordScene || node == recordLabel {
                recordLabel.fontColor = .lightGrayColor()
                self.view?.presentScene((recordScene as? SKScene)!, transition: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5))
            }
        }
    }
}
