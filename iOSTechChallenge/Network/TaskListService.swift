//
//  TaskListService.swift
//  iOSTechChallenge
//
//  Created by Raphael Pedrini on 26/02/2021.
//

import Foundation

class TaskListService: BaseService {
    
    func fetch (completionHandler: @escaping (Result<[Task], ServiceFetchError>) -> Void) {
        
        fetch(listOf: [Task].self, withURL: url(withPath: APIConstants.urls.taskList)) { (result) in
            switch result {
            case .success(let events):
                completionHandler(Result.success(events))
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
    }
}
