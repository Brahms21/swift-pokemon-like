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
    @StateObject var gameText = GameText()
    @State private var choosePokemon = false
    @State private var pokemonChosen = false
    @State private var logoScreen = true
    @State private var startAnimation = false
    @State private var transitionAnimation = false    
    @State private var opacity = 1.0
    @State private var opacity1 = 0.0
    @State private var opacity2 = 0.0
    @State private var opacity3 = 0.0
    @State private var opacity4 = 0.0
    
    func ChoosePokemonButton(_ chosenPokemon: String, _ enemyPokemon: String) {
        pokemon.name = chosenPokemon
        player.pokemons.append(pokemon)
        pokemon.enemyName = enemyPokemon
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
                        .font(.system(.headline)).foregroundColor(Color("ColorBlue"))
                    
                    TextField("Name", text: $player.name)
                        .padding()
                        .frame(width: 200, height: 50, alignment: .center)
                        .textFieldStyle(.roundedBorder)
                    
                    
                    Button(action: {
                        withAnimation(){
                            opacity2 -= 1.0
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
                   
                    Text("Oh \(player.name)! How could I ever Forget!").padding()
                        .multilineTextAlignment(.center)
                        .font(.system(.headline))
                   
                    Text(gameText.choosePokemon).padding().multilineTextAlignment(.center)
                        .font(.system(.headline))
                   
                    HStack{
                       
                        Button(action: {
                           ChoosePokemonButton("CHARMANDER", "SQUIRTLE")
                            pokemon.skill = "BLAZE"
                            pokemon.enemySkill = "TORRENT"
                        }) {
                            Image("charmander").pokemonImage()
                        }
                       
                        Button(action: {
                            ChoosePokemonButton("SQUIRTLE", "BULBASAUR")
                            pokemon.skill = "TORRENT"
                            pokemon.enemySkill = "OVERGROW"
                        }) {
                            Image("squirtle").pokemonImage()
                        }
                        
                        Button(action: {
                            ChoosePokemonButton("BULBASAUR", "CHARMANDER")
                            pokemon.skill = "OVERGROW"
                            pokemon.enemySkill = "BLAZE"
                            
                        }) {
                            Image("bulbasaur").pokemonImage()
                        }
                    } //: HSTACK
                }//: VSTACK
                .foregroundColor(Color("ColorBlue"))
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
                switch pokemon.name {
                case "CHARMANDER": Color(.red).ignoresSafeArea(.all, edges: .all)
                case "SQUIRTLE": Color(.blue).ignoresSafeArea(.all, edges: .all)
                case "BULBASAUR": Color(.green).ignoresSafeArea(.all, edges: .all)
                default: Color("ColorYellow").ignoresSafeArea(.all, edges: .all)
                }
                    
                VStack {
                    Spacer()
                    
                    Text("\(pokemon.name)! Great Choice! It's already starting to like you.").padding().multilineTextAlignment(.center).font(.system(.headline))
                    
                    Image("\(pokemon.name)".lowercased()).pokemonImage().padding()
                    
                    Spacer()
                   
                    Text(gameText.letsBattle + pokemon.enemyName)
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
                .foregroundColor(Color("ColorBlue"))
                .opacity(opacity4)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.5)) {
                            opacity4 += 1
                        }
                    }
            } //: ZSTACK
            
        }
    }
}

// PREVIEW
struct StartScreen_Previews: PreviewProvider {
    @State static var player = Player(pokemons: [Pokemon(name: "CHARMANDER", level: 1, enemyName: "SQUIRTLE", enemyLevel: 1, skill: "BLAZE", enemySkill: "TORRENT")])
    @State static var pokemon = Pokemon(name: "CHARMANDER", level: 1, enemyName: "SQUIRTLE", enemyLevel: 1, skill: "BLAZE", enemySkill: "TORRENT")
    static var previews: some View {
        StartScreen(player: $player, pokemon: $pokemon)
    }
}

