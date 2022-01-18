//
//  Lab1_DanielMiolan_c0817504_iOSUITestsLaunchTests.swift
//  Lab1_DanielMiolan_c0817504_iOSUITests
//
//  Created by Daniel Miolan on 1/18/22.
//

import XCTest

class Lab1_DanielMiolan_c0817504_iOSUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
