//
//  ItemScreen.swift
//  PokemonText
//
//  Created by Adib Najjar on 02/11/2021.
//

import SwiftUI

struct ItemScreen: View {
    
    // BINDING PROPERTIES
    
    @Binding var player: Player
    @Binding var itemsMenu: Bool
    @Binding var storeMenu: Bool
    
    // STATE PROPERTIES
    @State var opacity: Double = 0
    
    // BODY
    var body: some View {
        ZStack {
            Color("ColorYellow").ignoresSafeArea(.all, edges: .all)
            VStack {
                
                // BACK BUTTON
                HStack {
                    Button(action:{
                        itemsMenu = false
                    }){
                        Text("Back")
                        
                    }.buttonModify()
                    Spacer()
                    Text("Items").font(.title)
                    Spacer()
                    Image("pokepoints").resizable().frame(width: 60, height: 60, alignment: .leading)
                    Text(String(player.pokePoints)).font(.title)
                }.padding()
                Divider()
                
                // ITEMS
                VStack{
                    HStack {
                        
                        // POTIONS
                        Image("potion").resizable().frame(width: 50, height: 50, alignment: .center)
                        Text(player.items[0])
                        Spacer()
                        Text(String(player.potions))
                        
                        // ADD BUTTON - REDIRECT TO STORE
                        Button(action:{
                            itemsMenu = false
                            storeMenu = true
                        }){
                            Image(systemName: "plus")
                        }.buttonModify()
                    }.padding()
                    HStack {
                        
                        // POKEBALLS
                        Image("pokeball").resizable().frame(width: 50, height: 50, alignment: .center)
                        Text(player.items[1])
                        Spacer()
                        Text(String(player.pokeballs))
                        
                        // ADD BUTTON - REDIRECT TO STORE
                        Button(action:{
                            itemsMenu = false
                            storeMenu = true
                        }){
                            Image(systemName: "plus")
                        }.buttonModify()
                    }.padding()
                    Spacer()
                } //: VSTACK
                .onAppear{
                    
                    withAnimation(.easeOut(duration: 0.5)){
                        opacity += 1
                    }
                }.opacity(opacity)
            } //: VSTACK
        }
    }
}

// PREVIEW
struct ItemScreen_Previews: PreviewProvider {
    @State static var player = Player(pokemons: [pokemonArray[0]])
    @State static var itemsMenu = true
    @State static var storeMenu = false
    static var previews: some View {
        
        ItemScreen(player: $player, itemsMenu: $itemsMenu, storeMenu: $storeMenu)
    }
}
