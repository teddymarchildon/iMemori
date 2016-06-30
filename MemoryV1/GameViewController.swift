//
//  GameViewController.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/14/16.
//  Copyright (c) 2016 Teddy Marchildon. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateLocalPlayer()
        if let scene = MainMenu(fileNamed:"MainMenu") {
            let skView = self.view as! SKView
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .AspectFit
            skView.presentScene(scene)
        }
    }
    
    func authenticateLocalPlayer(){
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            if (viewController != nil) {
                self.presentViewController(viewController!, animated: true, completion: nil)
            } else {
                print((GKLocalPlayer.localPlayer().authenticated))
            }
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
