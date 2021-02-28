//
//  iOSTechChallengeTests.swift
//  iOSTechChallengeTests
//
//  Created by Raphael Pedrini on 26/02/2021.
//

import XCTest
@testable import iOSTechChallenge

class TaskListViewModelTests: XCTestCase {

    private let mockService = MockTaskListService()

    var viewModelMock: TaskListViewModel?
    
    override func setUp() {
        viewModelMock = TaskListViewModel(service: mockService)
    }

    override func tearDown() {
        viewModelMock = nil
    }
}
