//
//  PokemonData.swift
//  PokemonText
//
//  Created by Adib Najjar on 26/10/2021.
//

import Foundation
import SwiftUI

struct Pokemon: Identifiable, Hashable {
    
    // PROPERTIES
    var id = UUID()
    
    var name: String = ""
   
    var level: Int
    
    var exp = 0
   
    // CALCULATED PROPERTIES
    var maxHp: Int {(level * 5) + 15}
    
    var maxMp: Int {(level * 5) + 10}
    
    var hp: Int {get{maxHp}}
   
    var requiredExp: Int {level * 20}
    
    var giveExp: Int {(level * Int.random(in: 1...3)) + 5}
    
    var skillAtt: Int {level + Int.random(in: 1...4)}
    
    // SWITCH PROPERTIES
    var type: String{
        switch name{
        case "CHARMANDER": return "FIRE"
        case "SQUIRTLE": return "WATER"
        case "BULBASAUR": return "PLANT"
        case "MEWTWO": return "PSYCHIC"
        default: return "ERROR - NO SKILL"
        }
    }
    
    var skill: String{
        switch type{
        case "FIRE": return "BLAZE"
        case "WATER": return "TORRENT"
        case "PLANT": return "OVERGROW"
        case "PSYCHIC": return "PRESSURE"
        default: return "ERROR - NO SKILL"
        }
    }
   
    // INITIALIZERS
    init(name: String, level: Int){
        self.name = name
        self.level = level

    }
    
    // METHODS
    func choosePokemonText() -> String {
        
        // CHEATCODE
        if self.name == "MEWTWO"{
            return "Ash! I can't believe my eyes! Here's your legendary \(self.name)!"
        } else {
            return "\(self.name)! Great Choice! It's already starting to like you."
        }
        
    }
    
    func battleStartText() -> String{
        "A WILD \(self.name) has appeared!"
    }
    
    func attackText(_ att: Int) -> String{
        "\(self.name) has used \(self.skill)"
    }
    func loseHpText(_ att: Int) -> String{
                "\(self.name) has lost \(att) HP!"
    }
    func healPokemonText() -> String {
        "\(self.name) healed 5 HP"
    }
}

// DEFAULT ARRAY OF STRUCTS
var pokemonArray: [Pokemon] = [
    Pokemon(name: "CHARMANDER", level: 1),
    Pokemon(name: "SQUIRTLE", level: 1),
    Pokemon(name: "BULBASAUR", level: 1),
    Pokemon(name: "MEWTWO", level: 20)
    ]

