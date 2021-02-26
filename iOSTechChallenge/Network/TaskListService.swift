//
//  TaskListService.swift
//  iOSTechChallenge
//
//  Created by Raphael Pedrini on 26/02/2021.
//

import Foundation

class WeeklyTrendService: BaseService {
    
    func fetch (completionHandler: @escaping (Result<[Task], ServiceFetchError>) -> Void) {
        
        fetch(listOf: [Task].self, withURL: url(withPath: APIConstants.urls.weeklyTrendProducts)) { (result) in
            switch result {
            case .success(let events):
                completionHandler(Result.success(events))
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
    }
}
