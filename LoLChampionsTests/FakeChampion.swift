//
//  TopLevelUIUtilities.swift
//  LoLChampionsTests
//
//  Created by Karol on 25/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

import XCTest
@testable import LoLChampions

class FakeChampion{
    let champion = {
        return Champion(name: "TestChamp", roles: [.Top], type: [.AD])
    }
}
