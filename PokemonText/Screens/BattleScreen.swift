//
//  BattleScreen.swift
//  PokemonText
//
//  Created by Adib Najjar on 26/10/2021.
//

import SwiftUI


struct BattleScreen: View {
    @Binding var player: Player
    @Binding var pokemon: Pokemon
    @Binding var enemyPokemon: Pokemon
    @State private var itemList = false
    @State private var gameText = ""
    @State private var gameText2 = ""
    @State private var pokemonHp = 0
    @State private var enemyHp = 0
    @State private var pokemonMp = 0
    @State private var enemyMp = 0
    @State private var win = false
    @State private var lose = false
    @State private var itemMenu = false
    @State private var potions = 3
    @State private var pokeballs = 3
    @State private var opacity: Double = 0
    @AppStorage("mainMenu") var mainMenu = false
    @AppStorage("goToBattle") var goToBattle = true
    
    func enemyPokemonAtt(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let enemyAtt = enemyPokemon.skillAtt
            pokemonHp -= enemyAtt
            enemyMp -= 3
            if pokemonHp <= 0 {
                pokemonHp = 0
                lose = true
            }
            gameText2 = """
            \(enemyPokemon.attackText(enemyAtt))
\(pokemon.loseHpText(enemyAtt))
"""
        }
        
    }
    
    func catchPokemon(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            gameText2 = "3"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            gameText2 = "2"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            gameText2 = "1"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            if Int.random(in: 0...(enemyHp)) <= 2{
                gameText = """
    \(gameText)
    SUCCESS
    """
                player.pokemons.append(enemyPokemon)
                win = true
            } else {
                gameText = """
    \(gameText)
    FAILED to catch \(enemyPokemon.name)
    """
                enemyPokemonAtt()
            }
        }
        
    }
    
    
    
    var body: some View {
        
        ZStack {
            Color("ColorYellow").ignoresSafeArea(.all, edges: .all)
            VStack {
                    HStack(spacing: 20){
                        
                        VStack {
                            Image(pokemon.name.lowercased()).pokemonImage()
                            //Image("charmander").pokemonImage()
                            Text("\(pokemon.name)")
                            Text("HP: \(pokemonHp) / \(pokemon.maxHp)")
                            Text("MP: \(pokemonMp) / \(pokemon.maxMp)")
                        }
                        
                        Image("vs").resizable().scaledToFit()
                        
                        VStack {
                            Image(enemyPokemon.name.lowercased()).pokemonImage()
                            //Image("squirtle").pokemonImage()
                            Text("\(enemyPokemon.name)")
                            Text("HP: \(String(enemyHp)) / \(enemyPokemon.maxHp)")
                            Text("MP: \(enemyMp) / \(enemyPokemon.maxMp)")
                        }
                    }
                HStack(spacing: 50) {
                    Button(action:{
                        let pokemonAtt = pokemon.skillAtt
                        pokemonMp -= 3
                        enemyHp -= pokemonAtt
                        if enemyHp <= 0{
                            enemyHp = 0
                            win = true
                            return
                        }
                        gameText = """
                            \(pokemon.attackText(pokemonAtt))
                            \(enemyPokemon.loseHpText(pokemonAtt))
                            """
                        
                        enemyPokemonAtt()
                    }) {
                        Text("Attack")
                    }.buttonModify()
                    Button(action:{
                        itemMenu.toggle()
                    }) {
                        Text("Items")
                    }.buttonModify()
                    Button(action:{}){
                        Text("run")
                    }.buttonModify()
                }
                Text(gameText).padding().multilineTextAlignment(.center)
                Text(gameText2)
                
                if itemMenu{
                    VStack() {
                        Text("HEALING POTIONS: \(potions)")
                        Text("POKEBALLS: \(pokeballs)")
                    }.padding()
                    
                    HStack{
                        Button(action:{
                            potions -= 1
                            pokemonHp += 5
                            if pokemonHp > pokemon.maxHp{
                                pokemonHp = pokemon.maxHp
                            }
                            gameText = """
\(player.healPokemon())
\(pokemon.healPokemonText())
"""
                            enemyPokemonAtt()
                        }){
                            Text("Use HEALING POTION")
                        }.buttonModify()
                        Button(action:{
                            pokeballs -= 1
                            gameText = "\(player.name) has thrown a POKEBALL"
                            catchPokemon()
                        }){
                            Text("Throw POKEBALL")
                        }.buttonModify()
                    }.padding()
                }
            }
            
            if win{
                VStack {
                    
                    Text("YOU WON!").font(.largeTitle.bold()).background(.green)
                    Button(action:{
                        withAnimation(.easeIn(duration: 0.5)){
                            opacity -= 1
                        }
                        goToBattle = false
                        mainMenu = true
                    }){
                        
                        Image(systemName:"arrowtriangle.right.circle" )
                        Text("Tap to Continue")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                    }.buttonModify()
                }
                
            } else if lose{
                VStack {
                    
                    Text("YOU LOST").font(.largeTitle.bold()).background(.red)
                    Button(action:{
                        goToBattle = false
                        mainMenu = true
                    }){
                        
                        Image(systemName:"arrowtriangle.right.circle" )
                        Text("Tap to Continue")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                    }.buttonModify()
                }
            }
            
        }.onAppear{
            gameText = pokemon.battleStartText()
            pokemonHp = pokemon.maxHp
            enemyHp = enemyPokemon.maxHp
            pokemonMp = pokemon.maxMp
            enemyMp = enemyPokemon.maxMp
            withAnimation(.easeIn(duration: 0.5)) {
                opacity += 1
            }
        }.opacity(opacity)//: ZSTACK
    }
}



struct BattleScreen_Previews: PreviewProvider {
    @State static var player = Player(pokemons: [pokemonArray[0]])

    
    @State static var pokemon = pokemonArray[0]
    @State static var enemyPokemon = pokemonArray[1]
    static var previews: some View {
        BattleScreen(player: $player, pokemon: $pokemon, enemyPokemon: $enemyPokemon)
    }
}
