//
//  MainMenu.swift
//  PokemonText
//
//  Created by Adib Najjar on 26/10/2021.
//

import SwiftUI


struct MainMenu: View {
    @Binding var player: Player
    @State private var startAnimation = false
    @State private var opacity: Double = 0
    @AppStorage("goToBattle") var goToBattle = false
    @AppStorage("mainMenu") var mainMenu = true
    @State public var pokemonMenu = false
    @State public var itemsMenu = false
    @State public var storeMenu = false

    var body: some View {
        ZStack {
            Color("ColorYellow").ignoresSafeArea(.all, edges: .all)
            if mainMenu && !pokemonMenu && !itemsMenu && !storeMenu{
                VStack {
                    HStack {
                        Spacer()
                        Image("pokepoints").resizable().frame(width: 60, height: 60, alignment: .leading)
                        Text(String(player.pokePoints)).font(.title)
                    }.padding().opacity(opacity)
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .padding(0)
                        .scaleEffect(startAnimation ? 1.0 : 0.6)
                    
                    Spacer()
                    VStack{
                        Spacer()
                        Button(action:{
                            goToBattle = true
                            mainMenu = false
                        }){
                            Text("Battle!")
                        }.buttonModify()
                        Button(action:{
                            pokemonMenu = true
                        }){
                            Text("Pokemons")
                        }.buttonModify()
                        Button(action:{
                            itemsMenu = true
                        }){
                            Text("Items")
                        }.buttonModify()
                        Button(action:{
                            storeMenu = true
                        }){
                            Text("Store")
                        }.buttonModify()
                        Spacer()
                    }.opacity(opacity)//:VSTACK
                    
                } //: VSTACK
                .onAppear{
                    withAnimation(.easeOut(duration: 0.5)){
                        startAnimation = true
                    }
                    withAnimation(.easeOut(duration: 2.0)){
                        opacity += 1
                    }
                }
            } else if pokemonMenu{
                PokemonChoice(player: $player, pokemonMenu: $pokemonMenu)
            } else if itemsMenu{
                ItemScreen(player: $player, itemsMenu: $itemsMenu, storeMenu: $storeMenu)
            } else if storeMenu{
                StoreScreen(storeMenu: $storeMenu, player: $player)
            }
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    @State static var player = Player(name: "whatevs", pokemons: [pokemonArray[0], pokemonArray[3]])
    static var previews: some View {
        MainMenu(player: $player)
    }
}
