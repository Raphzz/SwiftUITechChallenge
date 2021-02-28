//
//  iOSTechChallengeTests.swift
//  iOSTechChallengeTests
//
//  Created by Raphael Pedrini on 26/02/2021.
//

import XCTest

@testable import iOSTechChallenge

class CacheHelperTests: XCTestCase {

    private let cacheHelper = CacheManager()

    private let mockTasksResponse = TaskListMockResponse()

    func testInit_AssertObjectIsBeingSavedToCache() {

        cacheHelper.save(mockTasksResponse.getTasks()?.first, key: String(describing: mockTasksResponse.getTasks()?.first?.id))

        let cachedData = cacheHelper.get(Task.self, key: String(describing: mockTasksResponse.getTasks()?.first?.id))

        XCTAssertNotNil(cachedData!)
        XCTAssert(cachedData!.type == mockTasksResponse.getTasks()?.first?.type)
    }

    func testInit_AssertArrayIsBeingSavedToCache() {

        cacheHelper.save(mockTasksResponse.getTasks())

        let cachedData = cacheHelper.get([Task]())

        XCTAssertNotNil(cachedData!)
        XCTAssert(cachedData!.first?.type == mockTasksResponse.getTasks()?.first?.type)
    }
}
