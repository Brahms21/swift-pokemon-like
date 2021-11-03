//
//  StoreScreen.swift
//  PokemonText
//
//  Created by Adib Najjar on 02/11/2021.
//

import SwiftUI

struct StoreScreen: View {
    
    // BINDING PROPERTIES
    @Binding var storeMenu: Bool
    @Binding var player: Player
    
    // STATE PROPERTIES
    @State private var opacity: Double = 0
    @State private var opacity2: Double = 0
    @State private var gameText = ""
    @State private var color = "ColorBlue"
    
    // FUNCTIONS
    
    // PURCHASE SUCCEEDED FUNCTION
    func onPurchase(){
        gameText = "Purchased"
        color = "ColorGreen"
        withAnimation(.easeOut(duration: 0.5)){
            opacity2 += 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            withAnimation(.easeOut(duration: 0.5)){
                opacity2 -= 1
            }
        }
    }
    
    // PURCHASE FAILED FUNCTION
    func onNoPurchase(){
        gameText = "Not Enough PokePoints"
        color = "ColorOrange"
        withAnimation(.easeOut(duration: 0.5)){
            opacity2 += 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            withAnimation(.easeOut(duration: 0.5)){
                opacity2 -= 1
            }
        }
        
    }
    
    // GRID LAYOUT
    let layout = [GridItem(.flexible(minimum: 40)),
                  GridItem(.flexible(minimum: 40)),
                  GridItem(.flexible(minimum: 40))]
    
    // BODY
    var body: some View {
        ZStack {
            Color("ColorYellow").ignoresSafeArea(.all, edges: .all)
            VStack {
                HStack {
                    
                    // BACK BUTTON
                    Button(action:{
                        storeMenu = false
                    }){
                        Text("Back")
                        
                    }.buttonModify()
                    Spacer()
                    
                    // TITLE
                    Text("Store").font(.title)
                    Spacer()
                    
                    // POKEPOINTS
                    Image("pokepoints").resizable().frame(width: 60, height: 60, alignment: .leading)
                    Text(String(player.pokePoints)).font(.title)
                }.padding()
                Divider()
                
                // GRID
                LazyVGrid(columns: layout){
                    
                    // RANDOM POKEMON PURCHASE BUTTON
                    Button(action: {
                        if player.pokePoints >= 300{
                            player.pokePoints -= 300
                                onPurchase()
                            
                        } else {
                                onNoPurchase()
                        }
                    }){
                        VStack {
                            Text("Random").multilineTextAlignment(.center)
                            Image("random").pokemonImage()
                            HStack {
                                Image("pokepoints").resizable().frame(width: 30, height: 30, alignment: .center)
                                Text("300")
                            }
                        }
                    }.buttonStyle(.bordered)
                    
                    // POKEBALL PURCHASE BUTTON
                    Button(action: {
                        if player.pokePoints >= 50{
                            player.pokeballs += 1
                            player.pokePoints -= 50
                            onPurchase()
                        
                    } else {
                            onNoPurchase()
                    }
                    }){
                        VStack {
                            Text("PokeBall").multilineTextAlignment(.center)
                            Image("pokeball").pokemonImage()
                            HStack {
                                Image("pokepoints").resizable().frame(width: 30, height: 30, alignment: .center)
                                Text("50")
                            }
                        }
                    }.buttonStyle(.bordered)
                    
                    // POTION PURCHASE BUTTON
                    Button(action: {
                        if player.pokePoints >= 10{
                            player.potions += 1
                            player.pokePoints -= 10
                            onPurchase()
                        
                    } else {
                            onNoPurchase()
                    }
                    }){
                        VStack {
                            Text("Potion").multilineTextAlignment(.center)
                            Image("potion").pokemonImage()
                            HStack {
                                Image("pokepoints").resizable().frame(width: 30, height: 30, alignment: .center)
                                Text("10")
                            }
                        }
                    }.buttonStyle(.bordered)
                }.opacity(opacity).foregroundColor(.black)
                Spacer()
                
                // PURCHASE SUCCEED OR FAIL CONTAINER
                ZStack {
                    Capsule().fill(Color(color))
                    Text(gameText).font(.title3).padding()
                }.scaledToFit().padding(.horizontal, 70).opacity(opacity2)

                Spacer()
            }//: VSTACK
        }.onAppear{
            withAnimation(.easeOut(duration: 0.5)){
                opacity += 1
            }
        }
    }
}

// PREVIEW
struct StoreScreen_Previews: PreviewProvider {
    @State static var storeMenu = true
    @State static var player = Player(pokemons: [pokemonArray[1]])
    static var previews: some View {
        StoreScreen(storeMenu: $storeMenu, player: $player)
    }
}
