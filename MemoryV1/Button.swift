//
//  Button.swift
//  Fremori
//
//  Created by Teddy Marchildon on 6/23/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import UIKit
import SpriteKit

class Button: SKSpriteNode {
    
    var label: SKLabelNode
    
    init(withText text: String) {
        let backTexture = SKTexture(imageNamed: "Button")
        label = SKLabelNode(text: text)
        super.init(texture: backTexture, color: UIColor(red: 0, green: 0, blue: 0, alpha: 0), size: backTexture.size())
        self.addChild(label)
        label.fontName = "System"
        label.horizontalAlignmentMode = .Center
        label.verticalAlignmentMode = .Center
        label.zPosition = 1
    }
    
    func setFont(withSize size: Int, andColor color: UIColor) {
        label.fontSize = CGFloat(size)
        label.fontColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
