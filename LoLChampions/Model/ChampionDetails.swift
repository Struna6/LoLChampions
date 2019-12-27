//
//  ChampionDetails.swift
//  LoLChampions
//
//  Created by Karol on 27/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

class ChampionDetails{
    init(attack: Int, defense: Int, magic: Int, difficulty: Int) {
        self.attack = attack
        self.defense = defense
        self.magic = magic
        self.difficulty = difficulty
    }
    
    let attack: Int
    let defense: Int
    let magic: Int
    let difficulty: Int
}
