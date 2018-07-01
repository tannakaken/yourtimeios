//
//  ClockList.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/06/30.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import Foundation

struct ClockList {
    static var index: Int = 0;
    private static var clocks: [Clock] = load()
    
    private init() {}
    
    static private func load() -> [Clock] {
        let manager = FileManager.default
        if let dir = manager.urls( for: .documentDirectory, in: .userDomainMask ).first {
            let filePath = dir.appendingPathComponent("clocks.txt")
            do {
                let text = try String( contentsOf: filePath, encoding: String.Encoding.utf8 )
                let data = text.components(separatedBy: "\n").map {str in return str.components(separatedBy: "\t")}
                var clocks : [Clock] = []
                for datum in data {
                    if datum.count == 1 {
                        break
                    }
                    clocks.append(Clock(name:datum[0],
                                        ampm: Ampm(rawValue: Int(datum[1])!)!,
                                        hours: Int(datum[2])!,
                                        minutes: Int(datum[3])!,
                                        seconds: Int(datum[4])!,
                                        dialFromOne: Bool(datum[5])!,
                                        clockwise: Bool(datum[6])!))
                }
                return clocks
            } catch {
                print("can't open file")
            }
            
        } else {
            fatalError()
        }
        return [
            Clock.defaultClock(),
            Clock(name: "24時間制逆進時計",
                  ampm: .am,
                  hours: 24,
                  minutes: 60,
                  seconds: 60,
                  dialFromOne: false,
                  clockwise:false),
            Clock(name: "革命暦十進時間",
                  ampm: .am,
                  hours: 10,
                  minutes: 100,
                  seconds: 100,
                  dialFromOne: false,
                  clockwise:true),
        ]
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
                fatalError()
            }
        } else {
            fatalError()
        }
    }
    
    static func count() -> Int {
        return self.clocks.count
    }
    
    static func clock(at index:  Int) -> Clock {
        return self.clocks[index]
    }
    
    static func index(of clock: Clock) -> Int? {
        return self.clocks.index(of: clock)
    }
    
    static func set(clock: Clock, at index: Int) {
        self.clocks[index] = clock
    }
}
