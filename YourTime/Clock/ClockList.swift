//
//  ClockList.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/06/30.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import Foundation
import WatchConnectivity

struct ClockList {
    static let limit: Int = 20
    static var index: Int = UserDefaults.standard.integer(forKey: "index") {
        didSet {
            if index < 0 || count() <= index {
                error_message = NSLocalizedString("irregalindex", comment: "")
                index = 0
            }
            UserDefaults.standard.set(self.index, forKey: "index")
        }
    }
    static var error_message: String? = nil
    private static var clocks: [Clock] = load()
    
    private init() {}
    
    static private func load() -> [Clock] {
        let manager = FileManager.default
        if let dir = manager.urls( for: .documentDirectory, in: .userDomainMask ).first {
            let filePath = dir.appendingPathComponent("clocks.txt")
            if (!manager.fileExists(atPath: filePath.path)) {
                return Clock.defaultClocks()
            }
            do {
                let text = try String( contentsOf: filePath, encoding: String.Encoding.utf8 )
                let lines = text.components(separatedBy: "\n")
                let data = lines[0..<(lines.count-1)].map {str in return str.components(separatedBy: "\t")}
                var clocks : [Clock] = []
                for datum in data {
                    if (datum.count != 7) {
                        error_message = NSLocalizedString("brokenfile", comment: "")
                        return Clock.defaultClocks()
                    }
                    if
                    let ampmValue = Int(datum[1]),
                    let ampm = Ampm(rawValue: ampmValue),
                    let hours = Int(datum[2]),
                    let minutes = Int(datum[3]),
                    let seconds = Int(datum[4]),
                    let dialFromOne = Bool(datum[5]),
                    let clockwise = Bool(datum[6]) {
                        clocks.append(Clock(name:datum[0],
                                            ampm: ampm,
                                            hours: hours,
                                            minutes: minutes,
                                            seconds: seconds,
                                            dialFromOne: dialFromOne,
                                            clockwise: clockwise
                                      )
                        )
                    } else {
                        error_message = NSLocalizedString("brokenfile", comment: "")
                        return Clock.defaultClocks()
                    }
                }
                if clocks.count == 0 {
                    error_message = NSLocalizedString("lostfile", comment: "")
                    return Clock.defaultClocks()
                }
                return clocks
            } catch {
                error_message = NSLocalizedString("unreadablefile", comment: "")
                return Clock.defaultClocks()
            }
        } else {
            error_message = NSLocalizedString("unreadbledirectory", comment: "")
            return Clock.defaultClocks()
        }
    }
    
    static func save() {
        let manager = FileManager.default
        var text = ""
        for clock in self.clocks {
            let datum = [clock.name,
                         String(clock.ampm.rawValue),
                         String(clock.hours),
                         String(clock.minutes),
                         String(clock.seconds),
                         String(clock.dialFromOne),
                         String(clock.clockwise)
            ]
            text += datum.joined(separator: "\t") + "\n"
        }
        if let dir = manager.urls( for: .documentDirectory, in: .userDomainMask ).first {
            let filePath = dir.appendingPathComponent("clocks.txt")
            do {
                try text.write( to: filePath, atomically: false, encoding: String.Encoding.utf8 )
            } catch {
                error_message = NSLocalizedString("unwritablefile", comment: "")
            }
            let session = WCSession.default
            session.transferFile(filePath, metadata: nil)
        } else {
            error_message = NSLocalizedString("unwritabledirectory", comment: "")
        }
    }
    
    static func count() -> Int {
        return self.clocks.count
    }
    
    static func clock(at index:  Int) -> Clock {
        return self.clocks[index]
    }
    
    static func index(of clock: Clock) -> Int? {
        return self.clocks.firstIndex(of: clock)
    }
    
    static func set(clock: Clock, at index: Int) {
        self.clocks[index] = clock
        self.save()
    }
    
    static func remove(at index: Int) -> Clock {
        assert(count() != 1, "ClockListの要素を0にすることは禁止されています。この関数より前でチェックすべきです。")
        let removedClock = self.clocks.remove(at: index)
        self.save()
        return removedClock
    }
    
    static func insert(_ clock: Clock, at index: Int) {
        assert(count() != limit - 1, "ClockListの長さの限度を超えます。この関数より前でチェックすべきです。")
        self.clocks.insert(clock, at: index)
        self.save()
    }
    
    static func append(_ clock: Clock) {
        assert(count() != limit - 1, "ClockListの長さの限度を超えます。この関数より前でチェックすべきです。")
        self.clocks.append(clock)
        self.save()
    }
}
