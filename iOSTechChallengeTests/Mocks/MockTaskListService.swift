//
//  BaseServiceMock.swift
//  iOSTechChallengeTests
//
//  Created by Raphael Pedrini on 28/02/2021.
//

import Foundation

@testable import iOSTechChallenge

class MockTaskListService: TaskListServiceProtocol {
    
    var isFetchBeingCalled = false
    
    func fetch(completionHandler: @escaping (Result<[Task], ServiceFetchError>) -> Void) {
        isFetchBeingCalled = true
    }
}
