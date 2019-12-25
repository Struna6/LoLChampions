//
//  Champion.swift
//  LoLChampions
//
//  Created by Karol on 25/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

class Champion{
    init(name: String, roles: [Champion.ChampionRole], type: [Champion.ChampionType]) {
        self.name = name
        self.roles = roles
        self.type = type
    }
    
    enum ChampionRole{
        case Top,Mid,Bottom,Support,Jungler
    }
    
    enum ChampionType{
        case AD,AP
    }
    
    var name: String
    var roles: [ChampionRole]
    var type: [ChampionType]
}


