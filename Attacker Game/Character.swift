//
//  Character.swift
//  Lecture 47
//
//  Created by Lucas Damiani on 03/11/15.
//  Copyright © 2015 Lucas Damiani. All rights reserved.
//

import Foundation

class Character {
    
    private(set) var name: String
    private(set) var hp: Int
    private(set) var attackPower: UInt
    
    var isAlive: Bool {
        return hp > 0
    }
    
    init(name: String, hp: Int, attackPower: UInt) {
        self.name = name
        self.hp = hp
        self.attackPower = attackPower
    }
    
    func defendAttack(attackerPower: UInt) {
        self.hp -= Int(attackerPower)
    }
    
}