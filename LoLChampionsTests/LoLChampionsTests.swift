//
//  LoLChampionsTests.swift
//  LoLChampionsTests
//
//  Created by Karol on 25/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

import XCTest
@testable import LoLChampions

class LoLChampionsTests: XCTestCase {
    var sut: ChampionsViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ChampionsViewController()
        _ = sut.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testChampionsViewIsNotHidden() {
        XCTAssertFalse(sut.view.isHidden)
    }
    
    func testChampionsViewTableIsNotHidden() {
        XCTAssertFalse(sut.championsTableView.isHidden)
    }
    
    func testChampionsViewTableDisplaysOneSection() {
        XCTAssertEqual(sut.championsTableView.numberOfSections, 1)
    }
    
    func testChampionsViewTableDisplaysOneCellOnFirstSection() {
        XCTAssertEqual(sut.championsTableView.numberOfRows(inSection: 0), 1)
    }

}
