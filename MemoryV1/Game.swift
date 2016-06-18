//
//  Game.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/16/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import Foundation
import SpriteKit


class Game {
    
    var playerOneTurn: Bool? = nil
    var playerTwoTurn: Bool? = nil
    var playerOneScore: Int? = nil
    var playerTwoScore: Int? = nil
    var score = 0
    var finished: Bool = false
    var cardsArray: [Card] = []
    var firstChoice: Card? = nil
    var secondChoice: Card? = nil
    
    init() {
        var valueSet = Set<Deck.Value>()
        while cardsArray.count < 8 {
            let card = Card()
            if valueSet.count == 13 { valueSet.removeAll() }
            if !valueSet.contains(card.value) {
                valueSet.insert(card.value)
                cardsArray.append(card)
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
                self.score += 100
                self.firstChoice = nil
                self.secondChoice = nil
                return true
            } else {
                self.score -= 20
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
        if let first = self.firstChoice, second = self.secondChoice {
            if first.isMatch(second) {
                if self.playerOneTurn! {
                    self.playerOneTurn = false
                    self.playerTwoTurn = true
                    self.playerOneScore! += 100
                } else {
                    self.playerOneTurn = true
                    self.playerTwoTurn = false
                    self.playerTwoScore! += 100
                }
                self.firstChoice = nil
                self.secondChoice = nil
                return true
            } else {
                if self.playerOneTurn! {
                    self.playerOneTurn = false
                    self.playerTwoTurn = true
                    self.playerOneScore! -= 20
                } else {
                    self.playerOneTurn = true
                    self.playerTwoTurn = false
                    self.playerTwoScore! -= 20
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