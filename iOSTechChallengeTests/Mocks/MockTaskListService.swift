//
//  BaseServiceMock.swift
//  iOSTechChallengeTests
//
//  Created by Raphael Pedrini on 28/02/2021.
//

import Foundation

@testable import iOSTechChallenge

class MockTaskListService: TaskListServiceProtocol {
    
    private let mockTasksResponse = TaskListMockResponse()
    
    var success = true
    
    func fetch(completionHandler: @escaping (Result<[Task], ServiceFetchError>) -> Void) {
        if success {
            completionHandler(Result.success(mockTasksResponse.getTasks()!))
        } else {
            let errorTemp = ServiceFetchError.invalidJSON
            completionHandler(Result.failure(errorTemp))
        }
    }
}
