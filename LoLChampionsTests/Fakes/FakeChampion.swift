//
//  TopLevelUIUtilities.swift
//  LoLChampionsTests
//
//  Created by Karol on 25/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

import XCTest
@testable import LoLChampions

class FakeChampion: ChampionLoaderImpl{
    override func loadChampions(completion: @escaping ([Champion]?) -> Void) {
        completion([Champion(name: "Aatrox", roles: [.Bottom], type: [.AD])])
    }
}
