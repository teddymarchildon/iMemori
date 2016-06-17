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
    var onePlayerMode: SKLabelNode!
    var twoPlayerMode: SKLabelNode!
    var cards: [SKSpriteNode] = []
    var game: Game? = nil
    var onePlayerScene: AnyObject? = nil
    var twoPlayerScene: AnyObject? = nil

    override func didMoveToView(view: SKView) {
        (self.cards, self.game) = LoadData.setUp()
        if let mainLabel = self.childNodeWithName("mainLabel") as? SKLabelNode, let onePlayerMode = self.childNodeWithName("onePlayerMode") as? SKLabelNode, let twoPlayerMode = self.childNodeWithName("twoPlayerMode") as? SKLabelNode {
            self.mainLabel = mainLabel
            self.onePlayerMode = onePlayerMode
            self.twoPlayerMode = twoPlayerMode
        }
        
        if let scene1 = OnePlayerGameScene(fileNamed:"OnePlayerGameScene") {
            self.onePlayerScene = scene1 as SKScene
            scene1.scaleMode = .AspectFill
            scene1.cards = cards
            scene1.game = game!
        }
        
        if let scene2 = TwoPlayerGameScene(fileNamed:"TwoPlayerGameScene") {
            self.twoPlayerScene = scene2 as SKScene
            scene2.scaleMode = .AspectFill
            scene2.cards = cards
            scene2.game = game!
            scene2.scaleMode = .AspectFill
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
            if node == onePlayerMode {
                self.view?.presentScene((onePlayerScene as? SKScene)!, transition: SKTransition.crossFadeWithDuration(1.5))
            } else if node == twoPlayerMode {
                self.view?.presentScene((twoPlayerScene as? SKScene)!, transition: SKTransition.crossFadeWithDuration(1.5))
            }
        }
    }
}
