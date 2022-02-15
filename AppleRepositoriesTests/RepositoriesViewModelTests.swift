//
//  RequestTest .swift
//  AppleRepositoriesTests
//
//  Created by Michał on 11/02/2022.
//

import XCTest
import Combine
@testable import AppleRepositories

class RepositoriesViewModeTests: XCTestCase {
  
  private var viewModel:RepositoriesViewModel!
  
  override func setUp() {
    viewModel = RepositoriesViewModel()
  }
  
  override func tearDown() {
    viewModel = nil
  }
  
  func testCorrectCreationDateFormatter() {
    let receivedDate = "2015-11-09T20:12:23Z"
    let formatedDate = "2015-11-09"
    XCTAssertEqual(viewModel.formatDate(receivedDate), formatedDate)
  }
  
  func testIncorrectCreationDateFormatter() {
    let receivedDate = "2015-11-09T20:12:"
    let formatedDate = "N/A"
    XCTAssertEqual(viewModel.formatDate(receivedDate), formatedDate)
  }
}
