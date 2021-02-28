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
    
    // Test fetch function from TaskListViewModel

    func test_FetchTaskList_Success() {
        mockService.success = true
        mockService.fetch{ (result) in
            switch result{
            case .success(let response):
                XCTAssert(response.count == 6)
                self.viewModelMock!.taskList = response
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    func test_FetchTaskList_Error() {
        mockService.success = false
        mockService.fetch{ (result) in
            switch result{
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssert(error == .invalidJSON)
            }
        }
    }
    
    func test_TestToggleFilter_WithFilter() {
        let taskTypeGeneral = TaskType.general
        
        viewModelMock?.toggleFilter(taskTypeGeneral)
        
        XCTAssertTrue(viewModelMock?.filteredList.count == 2)
    }
    
    func test_FiltersApplied_NoFilters() {
        let taskTypeGeneral = TaskType.general
        
        // Adding filter
        viewModelMock?.toggleFilter(taskTypeGeneral)
        
        // Removing filter
        viewModelMock?.toggleFilter(taskTypeGeneral)
        
        XCTAssertTrue(viewModelMock?.filteredList.count == 6)
    }
    
    func test_FilterListByType() {
        let taskTypeGeneral = TaskType.general
        
        viewModelMock?.filterListByType(taskTypeGeneral.rawValue)
        
        XCTAssert(viewModelMock?.filteredList.count == 2)
    }

    override func tearDown() {
        viewModelMock = nil
    }
}
