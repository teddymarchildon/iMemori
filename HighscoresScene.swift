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
    var hardHighestScoreRecordLabel: SKLabelNode!
    var hardFastestTimeRecordLabel: SKLabelNode!
    var regularHighestScoreRecordLabel: SKLabelNode!
    var regularFastestTimeRecordLabel: SKLabelNode!
    var mainMenuLabel: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        if let titleLabel = self.childNodeWithName("titleLabel") as? SKLabelNode, regularHighestScoreRecordLabel = self.childNodeWithName("regularHighscoreRecordLabel") as? SKLabelNode, regularFastestTimeRecordLabel = self.childNodeWithName("regularFastestTimeRecordLabel") as? SKLabelNode, mainMenuLabel = self.childNodeWithName("mainMenuLabel") as? SKLabelNode, hardHighestScoreRecordLabel = self.childNodeWithName("hardHighscoreRecordLabel") as? SKLabelNode, hardFastestTimeRecordLabel = self.childNodeWithName("hardFastestTimeRecordLabel") as? SKLabelNode {
            self.titleLabel = titleLabel
            self.regularHighestScoreRecordLabel = regularHighestScoreRecordLabel
            self.regularFastestTimeRecordLabel = regularFastestTimeRecordLabel
            self.mainMenuLabel = mainMenuLabel
            self.hardFastestTimeRecordLabel = hardFastestTimeRecordLabel
            self.hardHighestScoreRecordLabel = hardHighestScoreRecordLabel
        }
        guard let regularHighestScore = Records.regularHighscore, regularFastestTimeString = Records.regularFastestTimeString else {
            regularHighestScoreRecordLabel.text = "Play!"
            regularFastestTimeRecordLabel.text = "See how fast you can get!"
            return
        }
        regularHighestScoreRecordLabel.text = "Highest Score: \(regularHighestScore)"
        regularFastestTimeRecordLabel.text = "Fastest Time: " + regularFastestTimeString
        guard let hardHighestScore = Records.hardHighscore, hardFastestTimeString = Records.hardFastestTimeString else {
            regularHighestScoreRecordLabel.text = "Play!"
            regularFastestTimeRecordLabel.text = "See how fast you can get!"
            return
        }
        hardHighestScoreRecordLabel.text = "Highest Score: \(hardHighestScore)"
        hardFastestTimeRecordLabel.text = "Fastest Time: " + hardFastestTimeString
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
            if node == mainMenuLabel {
                mainMenuLabel.fontColor = .lightGrayColor()
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .AspectFit
                    self.view?.presentScene(scene, transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5))
                }

            }
        }
    }
}
