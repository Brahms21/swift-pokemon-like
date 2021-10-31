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
    @State private var itemList = false
    @State private var gameText = ""
    @State private var pokemonHp = 0
    @State private var enemyHp = 0
    @State private var pokemonMp = 0
    @State private var enemyMp = 0
    @State private var win = false
    @State private var lose = false
    @State private var itemMenu = false
    @State private var potions = 3
    @State private var pokeballs = 3
    
    func enemyPokemonAtt(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let enemyAtt = pokemon.enemySkillAtt
            if enemyHp <= 0{
                enemyHp = 0
                win = true
            }
            pokemonHp -= enemyAtt
            enemyMp -= 3
            if pokemonHp <= 0 {
                pokemonHp = 0
                lose = true
            }
            gameText = """
\(gameText)
\(pokemon.getAttackedText(enemyAtt))
"""
        }
        
    }
    
    func catchPokemon(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            gameText = """
\(gameText)
3
"""
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            gameText = """
\(gameText)
2
"""
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            gameText = """
\(gameText)
1
"""
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            if Int.random(in: 0...(enemyHp - 5)) == 0{
                gameText = """
    \(gameText)
    SUCCESS
    """
                
            } else {
                gameText = """
    \(gameText)
    FAILED
    """
            }
        }
        
    }
    
    
    
    var body: some View {
        
        ZStack {
            Color("ColorYellow").ignoresSafeArea(.all, edges: .all)
            VStack {
                    HStack(spacing: 20){
                        
                        VStack {
                            //Image(pokemon.name.lowercased())
                            Image("charmander").pokemonImage()
                            Text("\(pokemon.name)")
                            Text("HP: \(pokemonHp) / \(pokemon.maxHp)")
                            Text("MP: \(pokemonMp) / \(pokemon.maxMp)")
                        }
                        
                        Image("vs").resizable().scaledToFit()
                        
                        VStack {
                            //Image(pokemon.enemyName.lowercased())
                            Image("squirtle").pokemonImage()
                            Text("\(pokemon.enemyName)")
                            Text("HP: \(String(enemyHp)) / \(pokemon.enemyMaxHp)")
                            Text("MP: \(enemyMp) / \(pokemon.enemyMaxMp)")
                        }
                    }
                HStack(spacing: 50) {
                    Button(action:{
                        let pokemonAtt = pokemon.skillAtt
                        pokemonMp -= 3
                        enemyHp -= pokemonAtt
                        gameText = pokemon.attackText(pokemonAtt)
                        
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
                            gameText = "\(player.name) has used a HEALING POTION"
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
                    Button(action:{}){
                        
                        Image(systemName:"arrowtriangle.right.circle" )
                        Text("Tap to Continue")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                    }.buttonModify()
                }
                
            } else if lose{
                VStack {
                    
                    Text("YOU LOST").font(.largeTitle.bold()).background(.red)
                    Button(action:{}){
                        
                        Image(systemName:"arrow.counterclockwise.circle" )
                        Text("Tap to Restart")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                    }.buttonModify()
                }
            }
            
        }.onAppear{
            gameText = pokemon.battleStartText()
            pokemonHp = pokemon.maxHp
            enemyHp = pokemon.enemyMaxHp
            pokemonMp = pokemon.maxMp
            enemyMp = pokemon.enemyMaxMp
        }//: ZSTACK
    }
}



struct BattleScreen_Previews: PreviewProvider {
    @State static var player = Player(pokemons: [Pokemon(name: "CHARMANCER", level: 1, enemyName: "SQUIRTLE", enemyLevel: 1, skill: "BLAZE", enemySkill: "TORRENT")])

    
    @State static var pokemon = Pokemon(name: "CHARMANDER", level: 1, enemyName: "SQUIRTLE", enemyLevel: 1, skill: "BLAZE", enemySkill: "TORRENT")
    static var previews: some View {
        BattleScreen(player: $player, pokemon: $pokemon)
    }
}
