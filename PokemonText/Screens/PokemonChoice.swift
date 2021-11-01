//
//  PokemonChoice.swift
//  PokemonText
//
//  Created by Adib Najjar on 26/10/2021.
//

import SwiftUI

struct PokemonChoice: View {
    @Binding var player: Player
    @State private var color: String = "ColorYellow"
    @State private var opacity: Double = 0
    @Binding var pokemonMenu: Bool
    var body: some View {
        ZStack {
            Color(color).ignoresSafeArea(.all, edges: .all)
            VStack {
                Button(action:{
                    pokemonMenu = false
                }){
                    Text("Back to Main Menu")
                }
                NavigationView{
                        ZStack {
                            Color(color).ignoresSafeArea(.all, edges: .all)
                            TabView{
                                    ForEach(player.pokemons, id: \.self) {
                                        pokemon in
                                            VStack {
                                                Image(pokemon.name.lowercased()).resizable().scaledToFit()
                                                VStack {
                                                    HStack{
                                                        Text("POKEMON:")
                                                        Text(pokemon.name)
                                                    }
                                                    HStack{
                                                        Text("LEVEL:")
                                                        Text(String(pokemon.level))
                                                    }
                                                    Spacer()
                                                    Button(action:{}){
                                                        Text("Choose this Pokemon")
                                                    }.buttonModify().padding()
                                                    Spacer()
                                                }
                                            }
                                        
                                }.font(.title2)
                            }.tabViewStyle(PageTabViewStyle())
                        }
                    }.onAppear{
                        withAnimation(.easeOut(duration: 0.5)){
                            opacity += 1
                        }
                }.opacity(opacity)
            }
        }
        
    }
}

struct PokemonChoice_Previews: PreviewProvider {
    @State static var player = Player(name: "whatevs", items: ["whatevs"], pokemons: [pokemonArray[0], pokemonArray[3]])
    @State static var pokemonMenu = true
    static var previews: some View {
        PokemonChoice(player: $player, pokemonMenu: $pokemonMenu)
    }
}
