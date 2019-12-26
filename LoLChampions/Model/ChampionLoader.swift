//
//  ChampionLoader.swift
//  LoLChampions
//
//  Created by Karol on 25/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

import Foundation

protocol ChampionLoader{
    var champions : [Champion]? {get}
    var delegate: ChampionLoaderImplDelegate? {get set}
    func reload()
}

protocol ChampionLoaderImplDelegate : class{
    func championsLoadingFinishedSuccesfully()
    func championsloadingFailed()
}

class ChampionLoaderImpl: ChampionLoader{
    private(set) var champions: [Champion]?
    weak var delegate: ChampionLoaderImplDelegate?
    
    init(){
        reload()
    }
    
    func reload(){
        loadChampions {[weak self] (champ) in
            defer{
                if self?.champions != nil{
                    self?.delegate?.championsLoadingFinishedSuccesfully()
                }else{
                    self?.delegate?.championsloadingFailed()
                }
            }
            
            guard champ != nil else {return}
            self?.champions = champ
        }
    }
    
    func loadChampions(completion: @escaping ([Champion]?) -> Void) {
        let session = URLSession(configuration: .ephemeral)
        let url = URL(string: "https://guidescroll.com/2014/08/lol-champions-summary-list/")!
        session.dataTask(with: url, completionHandler: {[weak self] (data, _, error) in
            var champs : [Champion]?
            defer{
                DispatchQueue.main.async {
                    completion(champs)
                }
            }
            guard data != nil, error == nil else {return}
            let stringData = String(data: data!, encoding: .utf8)
            champs = self?.proceedData(from: stringData)
        }).resume()
    }
    
    private func proceedData(from html: String?) -> [Champion]?{
        guard html != nil else {return nil}
        let html = html!
        
        let start = html.range(of: "<table border=")?.upperBound
        let stop = html.range(of: "</table")?.lowerBound
        
        guard start != nil, stop != nil else {return nil}
        let content = html[start!..<stop!]
        var tab = content.components(separatedBy: "<tr>")
        tab.removeFirst()
        tab.removeFirst()
        
        var champions = [Champion]()
        
        for t in tab{
            var row = t.replacingOccurrences(of: " bgcolor=\"#CCCCCC\"", with: "").components(separatedBy: "<td>")
            row.removeFirst()
            var name = ""
            var types = [Champion.ChampionType]()
            var roles = [Champion.ChampionRole]()
            
            for (i,r) in row.enumerated(){
                switch i {
                    case 0:
                        let stop = r.range(of: "</td>")?.lowerBound
                        guard stop != nil else {continue}
                        let data = String(r[r.startIndex..<stop!])
                        name = data
                    case 1:
                        let stop = r.range(of: "</td>")?.lowerBound
                        guard stop != nil else {continue}
                        let data = String(r[r.startIndex..<stop!])
                        if data.contains("Top"){roles.append(.Top)}
                        if data.contains("Jungle"){roles.append(.Jungle)}
                        if data.contains("Mid"){roles.append(.Mid)}
                        if data.contains("Support"){roles.append(.Support)}
                        if data.contains("ADC"){roles.append(.Bottom)}
                    case 2:
                        let stop = r.range(of: "</td>")?.lowerBound
                        guard stop != nil else {continue}
                        let data = String(r[r.startIndex..<stop!])
                        switch data {
                        case _ where data.contains("AD"):
                            types.append(.AD)
                        case _ where data.contains("AP"):
                            types.append(.AP)
                        default:
                            break
                        }
                    default:
                        break
                }
            }
            guard name != "" else {continue}
            name = name.replacingOccurrences(of: "&#8217;", with: "'")
            let champion = Champion(name: name, roles: roles, type: types)
            champions.append(champion)
        }
        if champions.count > 0{
            return champions
        }else{
            return nil
        }
    }
}
