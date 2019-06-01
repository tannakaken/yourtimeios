//
//  YourTimeTests.swift
//  YourTimeTests
//
//  Created by Kensaku Tanaka on 2018/05/07.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import XCTest
@testable import YourTime

class ClockTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDefaultClock() {
        let clock = Clock.defaultClock()
        
        XCTAssertEqual(clock.name, NSLocalizedString("newtime", comment: ""))
        XCTAssertEqual(clock.hours, 12)
        XCTAssertEqual(clock.ampm, Ampm.ampm)
        XCTAssertEqual(clock.minutes, 60)
        XCTAssertEqual(clock.seconds, 60)
        XCTAssertEqual(clock.dialFromOne, true)
        XCTAssertEqual(clock.clockwise, true)
    }
    
    func testCustomizeClock() {
        let clock = customizeClock()
        
        XCTAssertEqual(clock.name, "decimal clock")
        XCTAssertEqual(clock.hours, 10)
        XCTAssertEqual(clock.ampm, Ampm.am)
        XCTAssertEqual(clock.minutes, 100)
        XCTAssertEqual(clock.seconds, 100)
        XCTAssertEqual(clock.dialFromOne, false)
        XCTAssertEqual(clock.clockwise, true)
    }
    
    func testDefaultClockCalculation() {
        let clock = Clock.defaultClock()
        let time = clock.calc(time: 1560000000)
        
        XCTAssertEqual(time.hour,1+20.0/60.0)
        XCTAssertEqual(time.minute, 20)
        XCTAssertEqual(time.second, 0)
    }
    
    func testCustomizeClockCalculation() {
        let clock = customizeClock()
        let time = clock.calc(time: 1560000000)
        
        XCTAssertEqual(time.hour,0.55)
        XCTAssertEqual(time.minute, 55)
        XCTAssertEqual(time.second, 55)
    }
    
    func customizeClock() -> Clock {
        return Clock(name: "decimal clock",
                     ampm: .am,
                     hours: 10,
                     minutes: 100,
                     seconds: 100,
                     dialFromOne: false,
                     clockwise:true)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
