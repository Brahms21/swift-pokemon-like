//
//  BattleScreen.swift
//  PokemonText
//
//  Created by Adib Najjar on 26/10/2021.
//

import SwiftUI


struct BattleScreen: View {
    
    // BINDING PROPERTIES
    @Binding var player: Player
    @Binding var pokemon: Pokemon
    @Binding var enemyPokemon: Pokemon
    
    // STATE PROPERTIES
    @State private var itemList = false
    @State private var gameText = ""
    @State private var gameText2 = ""
    @State private var pokemonHp = 0
    @State private var enemyHp = 0
    @State private var pokemonMp = 0
    @State private var enemyMp = 0
    @State private var potions = 0
    @State private var pokeballs = 0
    @State private var win = false
    @State private var lose = false
    @State private var itemMenu = false
    @State private var winText = ""
    @State private var loseText = ""
    @State private var opacity: Double = 0
    @State private var buttonOpacity: Double = 1
    @State private var attackButtonToggle: Bool = true
    @State private var itemsButtonToggle: Bool = true
    @State private var runButtonToggle: Bool = true
    @State private var winMainText = "YOU WON"
    
    // STORED PROPERTIES
    @AppStorage("mainMenu") var mainMenu = false
    @AppStorage("goToBattle") var goToBattle = true
    
    //FUNCTIONS:
    
    //PLAYER ATTACK FUNCTION
    func attackButtonAction(){
        if attackButtonToggle{
            let pokemonAtt = pokemon.skillAtt
            pokemonMp -= 3
            enemyHp -= pokemonAtt
            if enemyHp <= 0{
                enemyHp = 0
                pokemon.exp += enemyPokemon.giveExp
                winText = "\(pokemon.name) has gained \(enemyPokemon.giveExp) EXP."
                if pokemon.exp >= pokemon.requiredExp{
                    pokemon.exp -= pokemon.requiredExp
                    pokemon.level += 1
                    winText = """
            \(winText)
            \(pokemon.name) has leveled up to level \(pokemon.level)!
            """
                }
                player.pokemons.remove(at: 0)
                player.pokemons.insert(pokemon, at: 0)
                gainPokePoints()
                attackButtonToggle.toggle()
                itemsButtonToggle.toggle()
                runButtonToggle.toggle()
                player.potions = potions
                player.pokeballs = pokeballs
                win = true
                return
            }
            gameText = """
                \(pokemon.attackText(pokemonAtt))
                \(enemyPokemon.loseHpText(pokemonAtt))
                """
            gameText2 = ""
            enemyPokemonAtt()
        } else{
            return
        }
    }
    
    // ITEM BUTTON TOGGLE FUNCTION
    func itemsButtonAction(){
        if itemsButtonToggle{
            itemMenu.toggle()
        } else {
            return
        }

    }
    
    // ENEMY POKEMON ATTACK FUNCTION
    func enemyPokemonAtt(){
        attackButtonToggle.toggle()
        itemsButtonToggle.toggle()
        runButtonToggle.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let enemyAtt = enemyPokemon.skillAtt
            pokemonHp -= enemyAtt
            enemyMp -= 3
            attackButtonToggle.toggle()
            itemsButtonToggle.toggle()
            runButtonToggle.toggle()
            if pokemonHp <= 0 {
                pokemonHp = 0
                pokemon.exp -= enemyPokemon.giveExp
                if pokemon.exp <= 0{
                    pokemon.exp = 0
                }
                loseText = "\(pokemon.name) has lost \(enemyPokemon.giveExp) EXP."
                attackButtonToggle.toggle()
                itemsButtonToggle.toggle()
                runButtonToggle.toggle()
                player.potions = potions
                player.pokeballs = pokeballs
                lose = true
            }
            gameText2 = """
            \(enemyPokemon.attackText(enemyAtt))
\(pokemon.loseHpText(enemyAtt))
"""
        }
        
    }
    
    // CATCH POKEMON FUNCTION
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
                // INITIALIZATION OF NEW POKEMON STRUCT IF CAUGHT
                let enemyPokemonReInitialized = Pokemon(name: enemyPokemon.name, level: enemyPokemon.level)
                player.pokemons.insert(enemyPokemonReInitialized, at: player.pokemons.count)
                winText = "You have successfully caught \(enemyPokemon.name)!"
                gainPokePoints()
                attackButtonToggle.toggle()
                itemsButtonToggle.toggle()
                runButtonToggle.toggle()
                player.potions = potions
                player.pokeballs = pokeballs
                win = true
            } else {
                attackButtonToggle.toggle()
                runButtonToggle.toggle()
                gameText = """
    \(gameText)
    FAILED to catch \(enemyPokemon.name)
    """
                enemyPokemonAtt()
            }
        }
        
    }
    
    // GAIN POKEPOINTS FUNCTION
    func gainPokePoints(){
        let gainedPoints = enemyPokemon.level * Int.random(in: 2...4)
        player.pokePoints += gainedPoints
        winText = """
\(winText)
You gained \(gainedPoints) PokePoints!
"""
    }
    
    // BODY
    var body: some View {
        
        ZStack {
            Color("ColorYellow").ignoresSafeArea(.all, edges: .all)
            VStack {
                HStack {
                    VStack {
                        
                        // ITEMS IMAGES AND COUNT
                        HStack {
                            Image("potion").resizable().frame(width: 50, height: 50, alignment: .center)
                            Text(String(potions)).font(.title)
                        }
                        HStack {
                            Image("pokeball").resizable().frame(width: 50, height: 50, alignment: .center)
                            Text(String(pokeballs)).font(.title)
                        }
                    }
                    Spacer()
                    
                    // POKEPOINTS
                    Image("pokepoints").resizable().frame(width: 55, height: 50, alignment: .leading)
                    Text(String(player.pokePoints)).font(.title)
                }.padding(.horizontal, 30)
                Spacer()
                    HStack(spacing: 20){
                        
                        // PLAYER POKEMON IMAGE
                        VStack {
                            Image(pokemon.name.lowercased()).pokemonImage()
                            
                            // PLAYER POKEMON PROPERTIES
                            Text("\(pokemon.name)")
                            Text("Level: \(pokemon.level)")
                            Text("HP: \(pokemonHp) / \(pokemon.maxHp)")
                            Text("MP: \(pokemonMp) / \(pokemon.maxMp)")
                        }.frame(width: 150, height: 150, alignment: .center)
                        
                        // VS
                        Text("VS").bold().font(.title3)
                        
                        VStack {
                            
                            // ENEMY POKEMON IMAGE
                            Image(enemyPokemon.name.lowercased()).pokemonImage()
                            
                            //ENEMY POKEMON PROPERTIES
                            Text("\(enemyPokemon.name)")
                            Text("Level: \(enemyPokemon.level)")
                            Text("HP: \(String(enemyHp)) / \(enemyPokemon.maxHp)")
                            Text("MP: \(enemyMp) / \(enemyPokemon.maxMp)")
                        }.frame(width: 150, height: 150, alignment: .center)
                    }
                Spacer()
                HStack(spacing: 50) {
                    
                    // ATTACK BUTTON
                    Button(action:{
                        attackButtonAction()
                    }) {
                        Text("Attack")
                    }.buttonModify().opacity(buttonOpacity)
                    Button(action:{
                        itemsButtonAction()
                        attackButtonToggle.toggle()
                        runButtonToggle.toggle()
                    }) {
                        
                        // ITEMS BUTTON
                        Text("Items")
                    }.buttonModify()
                    Button(action:{
                        player.potions = potions
                        player.pokeballs = pokeballs
                        winText = "You ran away!"
                        winMainText = ""
                        win = true
                    }){
                        
                        // RUN BUTTON
                        Text("run")
                    }.buttonModify().opacity(buttonOpacity)
                }
                ZStack {
                    
                    // GAME TEXT CONTAINER
                    Color("ColorBeige")
                    VStack {
                        Text(gameText).multilineTextAlignment(.center)
                        Text(gameText2).multilineTextAlignment(.center).foregroundColor(Color("ColorOrange"))
                    }
                }.frame(width: 350, height: 200, alignment: .center).padding()
                
                Spacer()
                
                // ITEM MENU CONTAINER
                if itemMenu{
                    
                    HStack{
                        
                        // HEAL POKEMON BUTTON
                            Button(action:{
                                if potions > 0{
                                    attackButtonToggle.toggle()
                                    potions -= 1
                                    pokemonHp += 5
                                    if pokemonHp > pokemon.maxHp{
                                        pokemonHp = pokemon.maxHp
                                    }
                                    gameText2 = ""
                                    gameText = """
        \(player.healPokemon())
        \(pokemon.healPokemonText())
        """
                                    buttonOpacity += 1
                                    itemMenu = false
                                    enemyPokemonAtt()
                                } else {
                                    gameText = "Out of POTIONS!"
                                }
                                
                            }){
                                Text("Heal POKEMON")
                        }.buttonModify()
                        
                        
                            // CATCH POKEMON BUTTON
                            Button(action:{
                                if pokeballs > 0 {
                                    buttonOpacity += 1
                                    itemMenu = false
                                    pokeballs -= 1
                                    gameText = "\(player.name) has thrown a POKEBALL"
                                    catchPokemon()
                                } else {
                                    gameText = "Out of POKEBALLS!"
                                }
                                
                            }){
                                Text("Throw POKEBALL")
                        }.buttonModify()
                        
                    }.padding()
                    Spacer()
                }
            }
            
            // WIN SCREEN
            if win{
                VStack {
                    ZStack {
                        Capsule().fill(Color("ColorGreen"))
                        VStack {
                            Text(winMainText).font(.largeTitle.bold())
                            Text(winText).font(.title2)
                        }
                    }.scaledToFit()
                    
                    // CONTINUE BUTTON
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
                
                // LOSE SCREEN
            } else if lose{
                VStack {
                    
                    ZStack {
                        Capsule().fill(Color("ColorOrange"))
                        VStack {
                            Text("YOU LOST").font(.largeTitle.bold())
                            Text(loseText).font(.title2)
                        }
                    }.scaledToFit()
                    
                    // CONTINUE BUTTON
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
            
        }
        // INITIALIZATION OF PROPERTIES ON APPEAR
        .onAppear{
            var sumLevels = 0
            for item in player.pokemons{
                sumLevels += item.level
            }
            let averageLevel = sumLevels/player.pokemons.count
            pokemon = player.pokemons[0]
            enemyPokemon = pokemonArray[Int.random(in: 0...2)]
            enemyPokemon.level = averageLevel + Int.random(in: 0...2)
            pokemonHp = pokemon.maxHp
            enemyHp = enemyPokemon.maxHp
            pokemonMp = pokemon.maxMp
            enemyMp = enemyPokemon.maxMp
            potions = player.potions
            pokeballs = player.pokeballs
            gameText = enemyPokemon.battleStartText()
            
            withAnimation(.easeIn(duration: 0.5)) {
                opacity += 1
            }
        }.opacity(opacity)//: ZSTACK
    }
}


// PREVIEW
struct BattleScreen_Previews: PreviewProvider {
    @State static var player = Player(pokemons: [pokemonArray[0]])
    @State static var pokemon = pokemonArray[0]
    @State static var enemyPokemon = pokemonArray[1]
    static var previews: some View {
        BattleScreen(player: $player, pokemon: $pokemon, enemyPokemon: $enemyPokemon)
    }
}
