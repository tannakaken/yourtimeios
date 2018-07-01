//
//  Clock.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/06/28.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import Foundation

enum Ampm: Int {
    case am = 1
    case ampm = 2
    case ammmpm = 3
}

struct Time {
    let hour: Double
    let minute: Int
    let second: Int
}

extension Date {
    func millisecond() -> CLong {
        let calendar = Calendar.current
        let hour = CLong(calendar.component(.hour, from:self))
        let minute = CLong(calendar.component(.minute, from:self))
        let second = CLong(calendar.component(.second, from:self))
        let millisecond = CLong(self.timeIntervalSince1970 * 1000) % 1000
        return ((hour * 60 + minute) * 60 + second) * 1000 + millisecond
    }
}

class Clock: NSObject {
    let name: String
    let ampm: Ampm
    let hours: Int
    let minutes: Int
    let seconds: Int
    let dialFromOne: Bool
    let clockwise: Bool
    let sig: Double
    private let ONEDAY: Int64 = 1000 * 60 * 60 * 24
    private let MY_SECOND: Int
    private let MY_MINUTE: Int
    private let MY_HOUR: Int
    
    init(name : String,
         ampm : Ampm,
         hours : Int,
         minutes : Int,
         seconds: Int,
         dialFromOne: Bool,
         clockwise: Bool
         ) {
        self.name = name
        self.ampm = ampm
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.dialFromOne = dialFromOne
        self.clockwise = clockwise
        self.sig = clockwise ? 1.0 : -1.0
        self.MY_SECOND = Int(self.ONEDAY / Int64(seconds * minutes * hours * ampm.rawValue))
        self.MY_MINUTE = self.MY_SECOND * seconds
        self.MY_HOUR = self.MY_MINUTE * minutes
    }
    
    func calc(time: CLong) -> Time {
        let hourExact = Int(time / self.MY_HOUR % self.hours)
        let restOfHour = Int(time % self.MY_HOUR)
        let minute = restOfHour / self.MY_MINUTE
        let hour = Double(hourExact) + Double(minute) / Double(self.minutes)
        let restOfMinute = restOfHour % self.MY_MINUTE
        let second = restOfMinute / self.MY_SECOND
        return Time(hour: hour, minute: minute, second: second)
    }
    
    class func defaultClock() -> Clock {
        return Clock(name: "普通の時間",
                     ampm: .ampm,
                     hours: 12,
                     minutes: 60,
                     seconds: 60,
                     dialFromOne: true,
                     clockwise: true)
    }
}
