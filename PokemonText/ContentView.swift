//
//  ContentView.swift
//  PokemonText
//
//  Created by Adib Najjar on 26/10/2021.
//

import SwiftUI

struct ContentView: View {
    
    //PROPERTIES
    @State var player = Player(pokemons: [pokemonArray[0]])
    @State var pokemon = pokemonArray[0]
    @State var enemyPokemon = pokemonArray[1]
    
    //STORED PROPERTIES
    @AppStorage("goToBattle") var goToBattle = false
    @AppStorage("mainMenu") var mainMenu = false
   
    var body: some View {
        
        //BODY
        if goToBattle{
            BattleScreen(player: $player, pokemon: $pokemon, enemyPokemon: $enemyPokemon)
        } else if mainMenu == false{
            StartScreen(player: $player, pokemon: $pokemon, enemyPokemon: $enemyPokemon)
        } else if mainMenu == true {
            MainMenu(player: $player)
        } //: BODY
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
