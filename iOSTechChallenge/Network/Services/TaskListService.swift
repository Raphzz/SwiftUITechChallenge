//
//  TaskListService.swift
//  iOSTechChallenge
//
//  Created by Raphael Pedrini on 26/02/2021.
//

import Foundation

protocol TaskListServiceProtocol {
    func fetch (completionHandler: @escaping (Result<[Task], ServiceFetchError>) -> Void)
}

class TaskListService: BaseService, TaskListServiceProtocol {
    
    private let cache = CacheManager()
    
    func fetch (completionHandler: @escaping (Result<[Task], ServiceFetchError>) -> Void) {
        
        fetch(listOf: [Task].self, withURL: url(withPath: APIConstants.urls.taskList)) { (result) in
            
            #if DEBUG
            if CommandLine.arguments.contains("-mockListContent") {
                let mockResponse = TaskListMockResponse()
                completionHandler(Result.success(mockResponse.getTasks()!))
                return
            }
            #endif
            
            switch result {
            case .success(let tasks):
                self.cache.save(tasks)
                completionHandler(Result.success(tasks))
            case .failure(let error):
                guard let cachedTasks = self.getCachedTasks() else {
                    completionHandler(Result.failure(error))
                    return
                }
                completionHandler(Result.success(cachedTasks))
            }
        }
    }
}

extension TaskListService {
    func getCachedTasks() -> [Task]? {
        return self.cache.get([Task]())
    }
}
