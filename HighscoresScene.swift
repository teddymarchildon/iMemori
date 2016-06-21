//
//  HighscoresScene.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/20/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import UIKit
import SpriteKit

class HighscoresScene: SKScene {
    
    var titleLabel: SKLabelNode!
    var highestScoreRecordLabel: SKLabelNode!
    var fastestTimeRecordLabel: SKLabelNode!
    var mainMenuLabel: SKLabelNode!
    var game = Game()
    
    override func didMoveToView(view: SKView) {
        if let titleLabel = self.childNodeWithName("titleLabel") as? SKLabelNode, highestScoreRecordLabel = self.childNodeWithName("highscoreRecordLabel") as? SKLabelNode, fastestTimeRecordLabel = self.childNodeWithName("fastestTimeRecordLabel") as? SKLabelNode, mainMenuLabel = self.childNodeWithName("mainMenuLabel") as? SKLabelNode {
            self.titleLabel = titleLabel
            self.highestScoreRecordLabel = highestScoreRecordLabel
            self.fastestTimeRecordLabel = fastestTimeRecordLabel
            self.mainMenuLabel = mainMenuLabel
        }
        guard let highestScore = Records.highscore, fastestTimeString = Records.fastestTimeString else {
            highestScoreRecordLabel.text = "Play!"
            fastestTimeRecordLabel.text = "See how fast you can get!"
            return
        }
        highestScoreRecordLabel.text = "Highest Score: \(highestScore)"
        fastestTimeRecordLabel.text = "Fastest Time: " + fastestTimeString
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
            if node == mainMenuLabel {
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .AspectFit
                    self.view?.presentScene(scene, transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5))
                }

            }
        }
    }
}
