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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func clickedTwoPlayer(sender: AnyObject) {
        titleLabel.hidden = true
        onePlayerLabel.hidden = true
        twoPlayerLabel.hidden = true
        if let scene = TwoPlayerGameScene(fileNamed:"TwoPlayerGameScene") {
            // Configure the view.
            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            skView.presentScene(scene, transition: SKTransition.crossFadeWithDuration(2.0))
        }
    }
    
    @IBAction func clickedOnePlayer(sender: AnyObject) {
        titleLabel.hidden = true
        onePlayerLabel.hidden = true
        twoPlayerLabel.hidden = true
        if let scene = OnePlayerGameScene(fileNamed:"OnePlayerGameScene") {
            // Configure the view.
            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            skView.presentScene(scene, transition: SKTransition.crossFadeWithDuration(2.0))
        }
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
