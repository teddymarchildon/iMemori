//
//  GameViewController.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/14/16.
//  Copyright (c) 2016 Teddy Marchildon. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var onePlayerLabel: UIButton!
    @IBOutlet weak var twoPlayerLabel: UIButton!
    var cards: [SKSpriteNode] = []
    var game: Game? = nil
    var onePlayerScene: AnyObject? = nil
    var twoPlayerScene: AnyObject? = nil
    
    override func viewDidLoad() {
        (self.cards, self.game) = LoadData.setUp()
        super.viewDidLoad()
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
    
    @IBAction func clickedOnePlayer(sender: AnyObject) {
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        titleLabel.hidden = true
        onePlayerLabel.hidden = true
        twoPlayerLabel.hidden = true
        skView.presentScene(onePlayerScene as? SKScene)
    }
    
    @IBAction func clickedTwoPlayer(sender: AnyObject) {
        titleLabel.hidden = true
        onePlayerLabel.hidden = true
        twoPlayerLabel.hidden = true
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        skView.presentScene(twoPlayerScene as? SKScene)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
