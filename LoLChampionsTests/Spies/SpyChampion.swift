//
//  SpyChampion.swift
//  LoLChampionsTests
//
//  Created by Karol on 26/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

import XCTest
@testable import LoLChampions

class SpyChampion: ChampionLoaderImpl, ChampionLoaderImplDelegate{
    func championsLoadingFinishedSuccesfully() {
        counterSuccess += 1
    }
    
    func championsloadingFailed() {
        counterFailed += 1
    }
    
    var counterSuccess : Int = 0
    var counterFailed : Int = 0
    
    override func reload() {
        delegate = self
        super.reload()
    }
    
    override func loadChampions(completion: @escaping ([Champion]?) -> Void) {
        completion([Champion(name: "Aatrox", roles: [.Bottom], type: [.AD])])
    }
}
