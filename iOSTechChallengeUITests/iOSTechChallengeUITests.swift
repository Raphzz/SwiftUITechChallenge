//
//  iOSTechChallengeUITests.swift
//  iOSTechChallengeUITests
//
//  Created by Raphael Pedrini on 26/02/2021.
//

import XCTest

class iOSTechChallengeUITests: XCTestCase {
    
    // MARK:- LAUNCH ARGUMENTS
    
    private let offlineModeArgument = "-isOfflineMode"
    private let shouldMockListContentArgument = "-mockListContent"

    override func setUp() {
        continueAfterFailure = false
    }

    func test_List_WithMockResults() {
        
        // Given: The App is using Mock data
        let app = XCUIApplication()
        app.launchArguments = ["-mockListContent"]
        
        // When: App is launched
        app.launch()
        
        let taskList = app.tables["taskList"]
        let taskListExists = taskList.exists
        
        // Expect: List to exist with 6 results
        XCTAssertTrue(taskListExists)
        XCTAssertTrue(taskList.children(matching: .cell).count == 6 )
    }
    
    func test_List_FilterIsApplied() {
        
        // Given: The App is using Mock data
        let app = XCUIApplication()
        app.launchArguments = ["-mockListContent"]
        
        // When: App is launched
        app.launch()
        
        let taskList = app.tables["taskList"]
        let generalTypeFilterButton = app.buttons["general"]
        
        // And: Filter general tasks button is tapped
        generalTypeFilterButton.tap()
        
        // Expect: List to have 2 elements
        XCTAssertTrue(taskList.children(matching: .cell).count == 2 )
    }
    
    func test_OfflineBannerExists_WhenAirplaneMode_Active() {
        
        // Given: The App is in Offline mode
        let app = XCUIApplication()
        app.launchArguments = [offlineModeArgument]
        
        // When: App is launched
        app.launch()
        
        // Expect: Offline Banner to be visible
        let offlineBanner = app.staticTexts["offlineBanner"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: offlineBanner, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
