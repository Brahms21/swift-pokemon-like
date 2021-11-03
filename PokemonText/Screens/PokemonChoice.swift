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
                HStack {
                    Button(action:{
                        pokemonMenu = false
                    }){
                        Text("Back")
                        
                    }.buttonModify()
                    Spacer()
                    Text("Pokemons").font(.title)
                    Spacer()
                    Image("pokepoints").resizable().frame(width: 60, height: 60, alignment: .leading)
                    Text(String(player.pokePoints)).font(.title)
                }.padding()
                
                Divider()
                NavigationView{
                        ZStack {
                            Color(color).ignoresSafeArea(.all, edges: .all)
                                TabView{
                                        ForEach(player.pokemons) {
                                            pokemon in
                                                VStack {
                                                    Image(pokemon.name.lowercased()).resizable().scaledToFit()
                                                    VStack {
                                                        HStack{
                                                            Text("POKEMON:")
                                                            Text(pokemon.name)
                                                        }
                                                        HStack{
                                                            Spacer()
                                                            Text("LEVEL:")
                                                            Text(String(pokemon.level))
                                                            Spacer()
                                                            Text("EXP:")
                                                            Text(String(pokemon.exp))
                                                            Spacer()
                                                        }
                                                        HStack{
                                                            
                                                        }
                                                        Spacer()
                                                        if player.pokemons[0].id == pokemon.id{
                                                            Text("CURRENT POKEMON").font(.title2)
                                                        } else {
                                                            Button(action:{
                                                                let index =  player.pokemons.firstIndex(of: pokemon)
                                                                let element = player.pokemons.remove(at: index!)
                                                                player.pokemons.insert(element, at: 0)
                                                            }){
                                                                Text("Choose this Pokemon")
                                                            }.buttonModify().padding()
                                                        }
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
    @State static var player = Player(name: "whatevs", pokemons: [pokemonArray[0], pokemonArray[3]])
    @State static var pokemonMenu = true
    static var previews: some View {
        PokemonChoice(player: $player, pokemonMenu: $pokemonMenu)
    }
}
