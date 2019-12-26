//
//  LolChampionTestsChampionFlow.swift
//  LoLChampionsTests
//
//  Created by Karol on 26/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

import XCTest
@testable import LoLChampions

class LoLChampionsTestsChampionFlow: XCTestCase {
    var sut: ChampionsViewController!
    var fake : ChampionLoader!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fake = FakeChampion()
        sut = ChampionsViewController(championsLoader: fake)
        _ = sut.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        fake = nil
        super.tearDown()
    }
    
    func testIfOneChampion(){
        XCTAssertEqual(sut.championsLoader.champions?.count, 1)
    }
    
    func testAssertion(){
        XCTAssertEqual(sut.championsLoader.champions?.first, fake.champions?.first)
    }
    
    func testSuccessDelegateCalledOnce(){
        let spy = SpyChampion()
        sut.championsLoader = spy
        //sut.championsLoader.reload()
        XCTAssertEqual(spy.counterSuccess, 1)
    }
}
