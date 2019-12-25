//
//  ChampionLoader.swift
//  LoLChampions
//
//  Created by Karol on 25/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

import Foundation

protocol ChampionLoader{
    func loadChampions(completion: @escaping ([Champion], Error?) -> Void)
}

class ChampionLoaderImpl: ChampionLoader{
    func loadChampions(completion: @escaping ([Champion], Error?) -> Void) {
        let session = URLSession(configuration: .ephemeral)
        let url = URL(string: "https://guidescroll.com/2014/08/lol-champions-summary-list/")!
        session.dataTask(with: url, completionHandler: { (data, _, error) in
            
            guard data != nil, error == nil else {return}
            
        }).resume()
    }
    
    private func proceedData(contentOfURL: String) -> [Champion]?{
        return nil
    }
}
