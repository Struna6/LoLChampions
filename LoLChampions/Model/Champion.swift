//
//  Champion.swift
//  LoLChampions
//
//  Created by Karol on 25/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

import UIKit

class Champion{
    init(name: String, roles: [Champion.ChampionRole], type: [Champion.ChampionType]) {
        self.name = name
        self.roles = roles
        self.type = type
    }
    
    enum ChampionRole{
        case Top,Mid,Bottom,Support,Jungle
        
        var image : UIImage?{
            switch self {
            case .Top:
                return UIImage(named: "Top")
            case .Mid:
                return UIImage(named: "Mid")
            case .Bottom:
                return UIImage(named: "Bottom")
            case .Support:
                return UIImage(named: "Support")
            case .Jungle:
                return UIImage(named: "Jungle")
            }
        }
    }
    
    enum ChampionType{
        case AD,AP
        
        var image : UIImage?{
            switch self {
            case .AD:
                return UIImage(named: "AD")
            case .AP:
                return UIImage(named: "AP")
            }
        }
    }
    
    var name: String
    var roles: [ChampionRole]
    var type: [ChampionType]
}

extension Champion: Equatable{
    static func == (lhs: Champion, rhs: Champion) -> Bool {
        lhs.name == rhs.name
    }
}


