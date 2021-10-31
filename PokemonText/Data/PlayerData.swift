//
//  PlayerData.swift
//  PokemonText
//
//  Created by Adib Najjar on 26/10/2021.
//

import Foundation

struct Player{
    var name: String = ""
    var items = ["POTIONS","POKEBALLS"]
    var pokemons: [Pokemon]
    
    func healPokemon() -> String{
        "Player has used a HEALING POTION"
    }
    func throwPokeball() -> String {
        "Player has throw a POKEBALL"
    }
}

