//
//  Data.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/17/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import Foundation
import SpriteKit

class LoadData {

    static func setUp() -> ([SKSpriteNode], Game?) {
        let game = Game()
        let cards = game.cardsArray.shuffle()
        var a1 = setFirstRow(cards)
        let a2 = setSecondRow(cards)
        let a3 = setThirdRow(cards)
        let a4 = setFourthRow(cards)
        a1.appendContentsOf(a2)
        a1.appendContentsOf(a3)
        a1.appendContentsOf(a4)
        return (a1, game)
    }
    
    static func setFirstRow(cards: [Card]) -> [SKSpriteNode] {
        var positions: CGPoint = CGPoint(x: 155, y: 1250)
        var name = 0
        var ret: [SKSpriteNode] = []
        for num in 0...3 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: 180.0, height: 240.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 250
            ret.append(card)
        }
        return ret
    }
    
    static func setSecondRow(cards: [Card]) -> [SKSpriteNode] {
        var positions: CGPoint = CGPoint(x: 155, y: 920)
        var name = 4
        var ret: [SKSpriteNode] = []
        for num in 4...7 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: 180.0, height: 240.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 250
            ret.append(card)
        }
        return ret
    }
    
    static func setThirdRow(cards: [Card]) -> [SKSpriteNode] {
        var positions: CGPoint = CGPoint(x: 155, y: 600)
        var name = 8
        var ret: [SKSpriteNode] = []
        for num in 8...11 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: 180.0, height: 240.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 250
            ret.append(card)
        }
        return ret
    }
    
    static func setFourthRow(cards: [Card]) -> [SKSpriteNode] {
        var positions: CGPoint = CGPoint(x: 155, y: 240)
        var name = 12
        var ret: [SKSpriteNode] = []
        for num in 12...15 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: 180.0, height: 240.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 250
            ret.append(card)
        }
        return ret
    }
}