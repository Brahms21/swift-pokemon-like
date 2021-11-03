//
//  StartScreen.swift
//  PokemonText
//
//  Created by Adib Najjar on 26/10/2021.
//

import SwiftUI

extension Image {
    func pokemonImage() -> some View{
        self
            .resizable()
            .frame(width: 100, height: 100)
    }
}

extension Button {
    func buttonModify() -> some View{
        self
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
    }
}


struct StartScreen: View {
    
    // PROPERTIES
    @Binding var player: Player
    @Binding var pokemon: Pokemon
    @Binding var enemyPokemon: Pokemon
    @StateObject var gameText = GameText()
    @State private var choosePokemon = false
    @State private var pokemonChosen = false
    @State private var logoScreen = true
    @State private var startAnimation = false
    @State private var opacity = 1.0
    @State private var opacity1 = 0.0
    @State private var opacity2 = 0.0
    @State private var opacity3 = 0.0
    @State private var opacity4 = 0.0
    
    func ChoosePokemonButton(_ chosenPokemon: Int) {
        player.pokemons.remove(at: 0)
        player.pokemons.insert(pokemonArray[chosenPokemon], at: 0)
        pokemon = player.pokemons[0]
        
        if chosenPokemon < pokemonArray.count - 2 {
            enemyPokemon = pokemonArray[chosenPokemon + 1]
        } else {
            enemyPokemon = pokemonArray[0]
        }
        
        withAnimation(){
            opacity3 -= 1.0
        }
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            pokemonChosen = true
        }
    }
    
    @AppStorage("goToBattle") var goToBattle = false
    
    // BODY
    var body: some View {
        // LOGO SCREEN
        
        if logoScreen{
            
            ZStack {
               Color("ColorYellow")
                    .ignoresSafeArea(.all, edges: .all)
               
                VStack{
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .scaleEffect(startAnimation ? 1.0 : 0.6)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(){
                            opacity -= 1.0
                        }
                       
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            logoScreen = false
                        }
                    }) {
                       
                        Image(systemName: "arrowtriangle.right.circle")
                            .imageScale(.large)
                       
                        Text("Tap to Start")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                    }
                    .buttonModify()
                    .opacity(opacity1)
                }//: VSTACK
                .padding()
                    .opacity(opacity)
                   
            }//: ZSTACK
            .onAppear{
                withAnimation(.easeOut(duration: 0.5)){
                    startAnimation = true
                }
                withAnimation(.easeIn(duration: 3.0)){
                    opacity1 += 1
                }
            }
}
        // CHOOSE NAME SCREEN
        
        else if choosePokemon == false{
            ZStack {
                Color("ColorYellow").ignoresSafeArea(.all, edges: .all)
                
                VStack {
                    Text(gameText.chooseName)
                        .padding()
                        .multilineTextAlignment(.center)
                        .font(.system(.headline))
                    
                    TextField("Name", text: $player.name)
                        .padding()
                        .frame(width: 200, height: 50, alignment: .center)
                        .textFieldStyle(.roundedBorder)
                    
                    
                    Button(action: {
                        withAnimation(){
                            opacity2 -= 1.0
                        }
                        if player.name == "Ash Ketchum"{
                            choosePokemon = true
                            pokemonChosen = true
                            pokemon = pokemonArray[3]
                            player.pokemons.insert(pokemon, at: 0)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            choosePokemon = true
                        }
                    }) {
                        Text("GO")
                            .font(.system(.title2))
                            .bold()
                    }.buttonModify()
                }//: VSTACK
                .opacity(opacity2)
            }//: ZSTACK
            .onAppear{
                withAnimation(.easeIn(duration: 0.5)) {
                    opacity2 += 1
                }
            }
        }
        //CHOOSE POKEMON SCREEN
        
        else if pokemonChosen == false {
            ZStack {
                Color("ColorYellow").ignoresSafeArea(.all, edges: .all)
               
                VStack {
                   
                    Text(player.choosePlayer()).padding()
                        .multilineTextAlignment(.center)
                        .font(.system(.headline))
                   
                    Text(gameText.choosePokemon).padding().multilineTextAlignment(.center)
                        .font(.system(.headline))
                   
                    HStack{
                       
                        Button(action: {
                           ChoosePokemonButton(0)
                        }) {
                            Image("charmander").pokemonImage()
                        }
                       
                        Button(action: {
                            ChoosePokemonButton(1)
                        }) {
                            Image("squirtle").pokemonImage()
                        }
                        
                        Button(action: {
                            ChoosePokemonButton(2)
                            
                        }) {
                            Image("bulbasaur").pokemonImage()
                        }
                    } //: HSTACK
                }//: VSTACK
                .opacity(opacity3)
                    .onAppear{
                        withAnimation(.easeIn(duration: 0.5)) {
                            opacity3 += 1
                        }
                    }
            }
            // TRANSITION TO BATTLE SCREEN
        } else {
            
            ZStack {
                switch pokemon.type {
                case "FIRE": Color("ColorOrange").ignoresSafeArea(.all, edges: .all)
                case "WATER": Color("ColorAqua").ignoresSafeArea(.all, edges: .all)
                case "PLANT": Color("ColorGreen").ignoresSafeArea(.all, edges: .all)
                case "PSYCHIC": Color("ColorPurple").ignoresSafeArea(.all, edges: .all)
                default: Color("ColorYellow").ignoresSafeArea(.all, edges: .all)
                }
                    
                VStack {
                    Spacer()
                    
                    Text(pokemon.choosePokemonText()).padding().multilineTextAlignment(.center).font(.system(.headline))
                    
                    Image("\(pokemon.name)".lowercased()).resizable().scaledToFit().padding()
                    
                    Spacer()
                        .padding()
                        .multilineTextAlignment(.center)
                        .font(.system(.headline))
                    
                    Button(action:{
                        withAnimation(){
                            opacity4 -= 1.0
                        }
                       
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            goToBattle = true
                        }
                    }) {
                        
                        Text("GO")
                            .padding()
                            .multilineTextAlignment(.center)
                            .font(.system(.headline))
                            .foregroundColor(.white)
                    }.buttonModify()
                        .padding()
                }//: VSTACK
            }.opacity(opacity4)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.5)) {
                        opacity4 += 1
                    }
                } //: ZSTACK
            
        }
    }
}

// PREVIEW
struct StartScreen_Previews: PreviewProvider {
    @State static var player = Player(pokemons: [pokemonArray[0]])
    @State static var pokemon = pokemonArray[0]
    @State static var enemyPokemon = pokemonArray[1]
    static var previews: some View {
        StartScreen(player: $player, pokemon: $pokemon, enemyPokemon: $enemyPokemon)
    }
}

