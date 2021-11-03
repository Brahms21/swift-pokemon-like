//
//  PlayerData.swift
//  PokemonText
//
//  Created by Adib Najjar on 26/10/2021.
//

import Foundation

struct Player{
    
    //PROPERTIES
    var name: String = ""
   
    var items: [String] {["POTIONS", "POKEBALLS"]}
    
    var potions = 3
    
    var pokeballs = 3
    
    var pokemons: [Pokemon]
   
    var pokePoints: Int = 0
    
    //METHODS
    func choosePlayer() -> String {
        "Oh \(self.name)! How could I ever Forget!"
    }
    
    func healPokemon() -> String{
        "Player has used a HEALING POTION"
    }
    
    func throwPokeball() -> String {
        "Player has thrown a POKEBALL"
    }
}

