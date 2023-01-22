//
//  BuddyBankTests.swift
//  BuddyBankTests
//
//  Created by Max on 22/01/23.
//

import XCTest
@testable import BuddyBank

final class BuddyBankTests: XCTestCase {

  func testBase() {
    let mock = AppCoordinatorMock()
    let vm = PokemonListVM(coordinator: mock)
    XCTAssertTrue(mock.hasNavigationController)
    XCTAssertNil(mock.pokemon)

    
  }

}
//need to mock APIManager for filling PokemonListVM or needs to add a method only for test purpose.
