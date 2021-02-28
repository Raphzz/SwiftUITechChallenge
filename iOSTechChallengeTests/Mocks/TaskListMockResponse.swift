//
//  PostsMockResponse.swift
//  SwiftDemoExerciseTests
//
//  Created by Raphael Pedrini Velasqua on 05/12/2019.
//  Copyright © 2019 raph. All rights reserved.
//

import Foundation

@testable import iOSTechChallenge

class TaskListMockResponse {

    private var tasks: [Task]?

    init() {
        let bundle = Bundle(for: TaskListViewModelTests.self)

        if let path = bundle.url(forResource: "TaskListResponseMock", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                let response = try JSONDecoder().decode([Task].self, from: data)
                self.tasks = response
            } catch {}
        }
    }

    func getTasks() -> [Task]? {
        return tasks
    }
}
