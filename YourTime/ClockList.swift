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
    static var index: Int = UserDefaults.standard.integer(forKey: "index") {
        didSet {
            if index < 0 || count() <= index {
                error_message = "不正なインデックスが設定されたので修正します"
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
                print("initial clocks")
                return Clock.defaultClocks()
            }
            do {
                let text = try String( contentsOf: filePath, encoding: String.Encoding.utf8 )
                let lines = text.components(separatedBy: "\n")
                let data = lines[0..<(lines.count-1)].map {str in return str.components(separatedBy: "\t")}
                var clocks : [Clock] = []
                for datum in data {
                    if (datum.count != 7) {
                        error_message = "設定ファイルが壊れていました。"
                        print("can't parse data")
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
                        error_message = "設定ファイルが壊れていました。"
                        print("can't parse data")
                        return Clock.defaultClocks()
                    }
                }
                if clocks.count == 0 {
                    error_message = "設定ファイルが失われました。"
                    print("lost data")
                    return Clock.defaultClocks()
                }
                return clocks
            } catch {
                error_message = "設定ファイルを読めませんでした。"
                print("can't open file")
                return Clock.defaultClocks()
            }
        } else {
            error_message = "設定フォルダを読めませんでした。"
            print("can't open directory")
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
                error_message = "設定ファイルに書き込めませんでした"
                print("can't open file")
            }
            let session = WCSession.default
            session.transferFile(filePath, metadata: nil)
        } else {
            error_message = "設定フォルダに書き込めませんでした"
            print("can't open directory")
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
    
    static func remove(at index: Int) -> Clock {
        if count() == 1 {
            assert(false, "ClockListの要素を0にすることは禁止されています。この関数より前でチェックすべきです。")
        }
        return self.clocks.remove(at: index)
    }
    
    static func insert(_ clock: Clock, at index: Int) {
        self.clocks.insert(clock, at: index)
    }
    
    static func append(_ clock: Clock) {
        self.clocks.append(clock)
    }
}
