//
//  ChampionDetailsLoader.swift
//  LoLChampions
//
//  Created by Karol on 27/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

import Foundation

fileprivate struct ChampionDetailsResult{
}

protocol ChampionDetailsLoader{
    func get(championName: String, completion: @escaping (ChampionDetails?) -> Void)
}

class ChampionDetailsLoaderImpl : ChampionDetailsLoader{
    func get(championName: String, completion: @escaping (ChampionDetails?) -> Void) {
        let session = URLSession(configuration: .ephemeral)
        let url = URL(string: "http://ddragon.leagueoflegends.com/cdn/9.24.2/data/en_US/champion/\(championName).json")!
        
        session.dataTask(with: url, completionHandler: { (data, _, error) in
            var details : ChampionDetails?
            defer{
                completion(details)
            }
            
            guard data != nil, error == nil else {return}
            
        }).resume()
    }
}
