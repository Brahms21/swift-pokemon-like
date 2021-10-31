//
//  ContentView.swift
//  PokemonText
//
//  Created by Adib Najjar on 26/10/2021.
//

import SwiftUI

struct ContentView: View {
    @State var player = Player(pokemons: [Pokemon(name: "CHARMANDER", level: 1, enemyName: "SQUIRTLE", enemyLevel: 1, skill: "BLAZE", enemySkill: "TORRENT")])
    @State var pokemon = Pokemon(name: "", level: 1, enemyName: "SQUIRTLE", enemyLevel: 1, skill: "BLAZE", enemySkill: "TORRENT")
    @AppStorage("goToBattle") var goToBattle = false
   
    var body: some View {
        if goToBattle{
            BattleScreen(player: $player, pokemon: $pokemon)
        } else {
            StartScreen(player: $player, pokemon: $pokemon)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
