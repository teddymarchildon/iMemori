//
//  Data.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/17/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import Foundation
import SpriteKit

class LoadDataRegular {

    static func setUp() -> ([SKSpriteNode], Game) {
        let game = Game(difficulty: GameModes.DifficultyModes.Regular)
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
            card.size = CGSize(width: 210.0, height: 280.0)
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
            card.size = CGSize(width: 210.0, height: 280.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 250
            ret.append(card)
        }
        return ret
    }
    
    static func setThirdRow(cards: [Card]) -> [SKSpriteNode] {
        var positions: CGPoint = CGPoint(x: 155, y: 590)
        var name = 8
        var ret: [SKSpriteNode] = []
        for num in 8...11 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: 210.0, height: 280.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 250
            ret.append(card)
        }
        return ret
    }
    
    static func setFourthRow(cards: [Card]) -> [SKSpriteNode] {
        var positions: CGPoint = CGPoint(x: 155, y: 260)
        var name = 12
        var ret: [SKSpriteNode] = []
        for num in 12...15 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: 210.0, height: 280.0)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += 250
            ret.append(card)
        }
        return ret
    }
}

class LoadDataHard {
    
    static let width = 150.0
    static let height = 230.0
    static let xIncrement = CGFloat(integerLiteral: 170)
    static let xStart = 115
    
    static func setUp() -> ([SKSpriteNode], Game) {
        let game = Game(difficulty: GameModes.DifficultyModes.Hard)
        let cards = game.cardsArray.shuffle()
        var a1 = setFirstRow(cards)
        let a2 = setSecondRow(cards)
        let a3 = setThirdRow(cards)
        let a4 = setFourthRow(cards)
        let a5 = setFifthRow(cards)
        let a6 = setSixthRow(cards)
        a1.appendContentsOf(a2)
        a1.appendContentsOf(a3)
        a1.appendContentsOf(a4)
        a1.appendContentsOf(a5)
        a1.appendContentsOf(a6)
        return (a1, game)
    }
    
    
    static func setFirstRow(cards: [Card]) -> [SKSpriteNode] {
        var positions: CGPoint = CGPoint(x: xStart, y: 1400)
        var name = 0
        var ret: [SKSpriteNode] = []
        for num in 0...5 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: width, height: height)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += xIncrement
            ret.append(card)
        }
        return ret
    }
    
    static func setSecondRow(cards: [Card]) -> [SKSpriteNode] {
        var positions: CGPoint = CGPoint(x: xStart, y: 1150)
        var name = 4
        var ret: [SKSpriteNode] = []
        for num in 6...11 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: width, height: height)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += xIncrement
            ret.append(card)
        }
        return ret
    }
    
    static func setThirdRow(cards: [Card]) -> [SKSpriteNode] {
        var positions: CGPoint = CGPoint(x: xStart, y: 900)
        var name = 8
        var ret: [SKSpriteNode] = []
        for num in 12...17 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: width, height: height)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += xIncrement
            ret.append(card)
        }
        return ret
    }
    
    static func setFourthRow(cards: [Card]) -> [SKSpriteNode] {
        var positions: CGPoint = CGPoint(x: xStart, y: 650)
        var name = 12
        var ret: [SKSpriteNode] = []
        for num in 18...23 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: width, height: height)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += xIncrement
            ret.append(card)
        }
        return ret
    }
    
    static func setFifthRow(cards: [Card]) -> [SKSpriteNode] {
        var positions: CGPoint = CGPoint(x: xStart, y: 400)
        var name = 12
        var ret: [SKSpriteNode] = []
        for num in 24...29 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: width, height: height)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += xIncrement
            ret.append(card)
        }
        return ret
    }
    
    static func setSixthRow(cards: [Card]) -> [SKSpriteNode] {
        var positions: CGPoint = CGPoint(x: xStart, y: 150)
        var name = 12
        var ret: [SKSpriteNode] = []
        for num in 30...35 {
            let card = cards[num] as SKSpriteNode
            card.size = CGSize(width: width, height: height)
            card.position = positions
            card.name = "\(name)"
            name += 1
            positions.x += xIncrement
            ret.append(card)
        }
        return ret
    }
}
