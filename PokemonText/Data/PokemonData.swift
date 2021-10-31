//
//  PokemonData.swift
//  PokemonText
//
//  Created by Adib Najjar on 26/10/2021.
//

import Foundation
import SwiftUI

struct Pokemon {
    var name: String = ""
    var enemyName: String = ""
   
    var level: Int
    var enemyLevel: Int
   
    var maxHp: Int {
        (level * 5) + 15
    }
    
    var maxMp: Int {
        (level * 5) + 10
    }
    
    var enemyMaxMp: Int{
        (level * 5) + 10
    }
    
    var enemyMaxHp: Int {
        (enemyLevel * 5) + 15
    }
   
    var hp: Int {
        get{
            maxHp
        }
    }
    var enemyHp: Int {
        enemyMaxHp
    }
   
    var exp = 0
    var requiredExp: Int {
        level * 20
    }
    var giveExp: Int {
        (level * Int.random(in: 1...3)) + 5
    }
    
   
    var skillAtt: Int {
        level + Int.random(in: 1...4)
    }
    var enemySkillAtt: Int{
        enemyLevel + Int.random(in: 1...4)
    }
    
    var skill: String
    var enemySkill: String
    
    init(name: String, level: Int, enemyName:String, enemyLevel: Int, skill: String, enemySkill: String){
        self.level = level
        self.enemyLevel = enemyLevel
        self.skill = skill
        self.enemySkill = enemySkill
    }
    
    /*mutating func getAttacked(){
        self.hp -= self.enemySkillAtt
    }
    mutating func gainExp(){
        self.exp += self.giveExp
    }
    mutating func levelUp(){
        self.level += 1
    }
    mutating func healPokemon() {
        self.hp += 10
        if self.hp > self.maxHp{
            self.hp = self.maxHp
        }
    }*/
    
    func battleStartText() -> String{
        "A WILD \(self.enemyName) has appeared!"
    }
    
    func attackText(_ att: Int) -> String{
        """
\(self.name) has used \(self.skill)
\(self.enemyName) has lost \(att) HP!
"""
    }
    func getAttackedText(_ att: Int) -> String{
                """
        \(self.enemyName) has used \(self.enemySkill)
        \(self.name) has lost \(att) HP!
        """
    }
    func healPokemonText() -> String {
        """
You gave \(self.name) a healing potion
\(self.name)'s HP is now \(self.hp)
"""
    }
}




//implement the status with willSet and didSet so we can get the info and the new info conveniently
//try to use private(set) syntax for setters see if it works out
//use protocols for functions(e.g. when a pokemon attacks) that are shared with different structs

