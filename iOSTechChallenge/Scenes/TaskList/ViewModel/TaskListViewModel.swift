//
//  TaskListViewModel.swift
//  iOSTechChallenge
//
//  Created by Raphael Pedrini on 26/02/2021.
//

import Foundation
import Reachability

enum TaskType: String {
    case general = "general"
    case hydration = "hydration"
    case medication = "medication"
    case nutrition = "nutrition"
    case invalid = "invalid"
}

class TaskListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let taskListService: TaskListServiceProtocol
    
    private let reachability = try! Reachability()
    
    @Published var filteredList: [Task] = []
    
    @Published var isOnline: Bool?
    
    let taskTypes = [
        TaskType.general,
        TaskType.hydration,
        TaskType.medication,
        TaskType.nutrition
    ]
    
    // MARK: - Computed Properties
    
    @Published var filtersApplied: [TaskType] = [] {
        didSet {
            filteredList = taskList.filter { task in
                guard !filtersApplied.isEmpty else { return true }
                guard let type = TaskType(rawValue: task.type) else { return false }
                
                return filtersApplied.contains(type)
            }
        }
    }
    
    var taskList: [Task] = [] {
        didSet {
            filteredList = taskList
        }
    }
    
    init(service: TaskListServiceProtocol) {
        self.taskListService = service
        startReachability()
        fetchTaskList()
    }
    
    // MARK: - Public methods
    
    func fetchTaskList() {
        taskListService.fetch { [weak self] (result) in
            switch result{
            case .success(let response):
                self?.taskList = response
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func toogleFilter(_ filter: TaskType) {
        if filtersApplied.contains(filter) {
            filtersApplied = filtersApplied.filter { $0 != filter }
        } else {
            filtersApplied.append(filter)
        }
    }
    
    func filterListByType(_ type: String) {
        filteredList = taskList.filter { $0.type == type }
    }
    
    // MARK: - Private Functions
    
    private func startReachability() {
        reachability.startReachability() { bool in
            self.isOnline = bool
        }
    }
}
