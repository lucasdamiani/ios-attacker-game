//
//  Game.swift
//  Lecture 47
//
//  Created by Lucas Damiani on 03/11/15.
//  Copyright © 2015 Lucas Damiani. All rights reserved.
//

import Foundation

class Game {
    
    private(set) var player1: Character
    
    private(set) var player2: Character
    
    private(set) var winner: Character?
    
    private(set) var loser: Character?
    
    var isFinished: Bool {
        return winner != nil && loser != nil
    }
    
    required init(player1: Character, player2: Character) {
        self.player1 = player1
        self.player2 = player2
    }
    
    convenience init() {
        self.init(player1: Character(name: "Orc", hp: 100, attackPower: 10), player2: Character(name: "Knight", hp: 75, attackPower: 20))
    }
    
    func attackPlayer1() -> Bool {
        return self.attackPlayer(self.player1, attacker: self.player2)
    }
    
    func attackPlayer2() -> Bool {
        return self.attackPlayer(self.player2, attacker: self.player1)
    }
    
    private func attackPlayer(defender: Character, attacker: Character) -> Bool {
        if isFinished {
            return false
        }
        
        defender.defendAttack(attacker.attackPower)
        if !defender.isAlive {
            self.endGame(attacker, loser: defender)
        }
        
        return true
    }
    
    private func endGame(winner: Character, loser: Character) {
        self.winner = winner
        self.loser = loser
    }
}