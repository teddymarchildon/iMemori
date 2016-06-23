//
//  Game.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/16/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import Foundation
import SpriteKit

enum GameModes {
    
    enum PlayerModes: String {
        case Choose = "Choose..."
        case OnePlayer = "One Player"
        case TwoPlayer = "Two Players"
    }
    
    enum DifficultyModes: String {
        case Choose = "Choose..."
        case Regular = "Regular"
        case Hard = "Hard"
    }
}

class Game {
    
    var playerOneTurn: Bool? = nil
    var playerTwoTurn: Bool? = nil
    var playerOneScore: Int? = nil
    var playerTwoScore: Int? = nil
    var score: Int = 0
    var finished: Bool = false
    var cardsArray: [Card] = []
    var firstChoice: Card? = nil
    var secondChoice: Card? = nil
    var difficulty: GameModes.DifficultyModes
    var multiplier: Int = 1
    var playerOneMultiplier: Int? = nil
    var playerTwoMultiplier: Int? = nil
    
    convenience init() {
        self.init(difficulty: GameModes.DifficultyModes.Regular)
    }
    
    init(difficulty: GameModes.DifficultyModes) {
        self.difficulty = difficulty
        if difficulty == .Regular {
            var valueSet = Set<Deck.Value>()
            while cardsArray.count < 8 {
                let card = Card()
                if valueSet.count == 13 { valueSet.removeAll() }
                if !valueSet.contains(card.value) {
                    valueSet.insert(card.value)
                    cardsArray.append(card)
                }
            }
        } else if difficulty == .Hard {
            var valueSet = Set<Deck.Value>()
            var suits = [Deck.Suit.clubs, Deck.Suit.diamonds, Deck.Suit.hearts, Deck.Suit.spades]
            var counter = 0
            while cardsArray.count < 18 {
                if valueSet.count == 5 {
                    valueSet.removeAll()
                    counter += 1
                }
                let card = Card(withSuit: suits[counter])
                if !valueSet.contains(card.value) {
                    valueSet.insert(card.value)
                    cardsArray.append(card)
                }
            }
        }
        for card in cardsArray {
            let cardCopy = Card(cardSuit: card.suit, cardValue: card.value, flipTexture: card.flipTexture)
            cardsArray.append(cardCopy)
        }
    }
    
    func isOver() -> Bool {
        return self.finished
    }
    
    func onePlayerTestMatch() -> Bool {
        if let first = self.firstChoice, second = self.secondChoice {
            if first.isMatch(second) {
                self.score += 100 * multiplier
                multiplier += 1
                self.firstChoice = nil
                self.secondChoice = nil
                return true
            } else {
                self.score -= 20
                multiplier = 1
                first.selected = false
                second.selected = false
                self.firstChoice = nil
                self.secondChoice = nil
                return false
            }
        }
        return false
    }
    
    func twoPlayerTestMatch() -> Bool {
        if let first = self.firstChoice, second = self.secondChoice, playerOneMultiplier = playerOneMultiplier, playerTwoMultiplier = playerTwoMultiplier {
            if first.isMatch(second) {
                if self.playerOneTurn! {
                    self.playerOneTurn = false
                    self.playerTwoTurn = true
                    self.playerOneScore! += 100 * playerOneMultiplier
                    self.playerOneMultiplier! += 1
                } else {
                    self.playerOneTurn = true
                    self.playerTwoTurn = false
                    self.playerTwoScore! += 100 * playerTwoMultiplier
                    self.playerTwoMultiplier! += 1
                }
                self.firstChoice = nil
                self.secondChoice = nil
                return true
            } else {
                if self.playerOneTurn! {
                    self.playerOneTurn = false
                    self.playerTwoTurn = true
                    self.playerOneScore! -= 20
                    self.playerOneMultiplier = 1
                } else {
                    self.playerOneTurn = true
                    self.playerTwoTurn = false
                    self.playerTwoScore! -= 20
                    self.playerTwoMultiplier = 1
                }
                first.selected = false
                second.selected = false
                self.firstChoice = nil
                self.secondChoice = nil
                return false
            }
        }
        return false
    }
}