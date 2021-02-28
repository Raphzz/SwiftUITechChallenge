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

    private let mockPostsResponse = TaskListMockResponse()

    func testInit_AssertObjectIsBeingSavedToCache() {

        cacheHelper.save(mockPostsResponse.getResponse()?.first, key: String(describing: mockPostsResponse.getResponse()?.first?.id))

        let cachedData = cacheHelper.get(Task.self, key: String(describing: mockPostsResponse.getResponse()?.first?.id))

        XCTAssertNotNil(cachedData!)
        XCTAssert(cachedData!.type == mockPostsResponse.getResponse()?.first?.type)
    }

    func testInit_AssertArrayIsBeingSavedToCache() {

        cacheHelper.save(mockPostsResponse.getResponse())

        let cachedData = cacheHelper.get([Task]())

        XCTAssertNotNil(cachedData!)
        XCTAssert(cachedData!.first?.type == mockPostsResponse.getResponse()?.first?.type)
    }
}
