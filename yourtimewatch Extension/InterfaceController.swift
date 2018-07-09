//
//  InterfaceController.swift
//  yourtimewatch Extension
//
//  Created by Kensaku Tanaka on 2018/07/06.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var clocks: [Clock] = Clock.defaultClocks()
    var index = 0
    
    @IBOutlet var image: WKInterfaceImage!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            self.send(session)
        }
        let manager = FileManager.default
        if let dir = manager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = dir.appendingPathComponent("clocks.txt")
            self.clocks = self.parse(url: filePath)
        }
    }
    
    func send(_ session: WCSession) {
        session.sendMessage([:], replyHandler: nil, errorHandler: {(error) in
            self.send(session)
        })
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.draw()
        self.animation()
    }
    
    func draw() {
        let width = self.contentFrame.width
        let height = self.contentFrame.height
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        if let context : CGContext = UIGraphicsGetCurrentContext() {
            context.setFillColor(UIColor.white.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: width, height: height))
            let now = clocks[index].calc(time: Date().millisecond())
            let hourUnitAngle = Clock.unitAngle(totalNum: clocks[index].hours)
            let hourRadian = clocks[index].sig * now.hour * hourUnitAngle
            let hourLength = self.contentFrame.midX * 0.3
            drawNeedle(width: CGFloat(3.0), length: hourLength, radian: hourRadian, context: context)
            let minuteUnitAngle = Clock.unitAngle(totalNum: clocks[index].minutes)
            let minuteRadian = clocks[index].sig * Double(now.minute) * minuteUnitAngle
            let minuteLength = self.contentFrame.midX * 0.5
            drawNeedle(width: CGFloat(1.5), length: minuteLength, radian: minuteRadian, context: context)
            let secondUnitAngle = Clock.unitAngle(totalNum: clocks[index].seconds)
            let secondRadian = clocks[index].sig * Double(now.second) * secondUnitAngle
            let secondLength = self.contentFrame.midX * 0.7
            drawNeedle(width: CGFloat(0.8), length: secondLength, radian: secondRadian, context: context)
            drawDial()
            if let cgImage:CGImage = context.makeImage() {
                let uiImage = UIImage(cgImage: cgImage)
                UIGraphicsEndImageContext()
                self.image.setImage(uiImage)
            }
        }
    }
    
    func drawDial() {
        let fontSize = CGFloat(10)
        let attributes: [NSAttributedStringKey : AnyObject] = [
            .font: UIFont.systemFont(ofSize: fontSize),
            .foregroundColor: UIColor.black
        ]
        let radius = self.contentFrame.midX * 0.8
        let angle = clocks[index].sig * Clock.unitAngle(totalNum: clocks[index].hours)
        let range = clocks[index].dialFromOne ? 1...clocks[index].hours : 0...(clocks[index].hours-1)
        for i in range {
            let x = self.contentFrame.midX + radius * CGFloat(sin(Double(i) * angle)) - fontSize/2
            let y = self.contentFrame.midY - radius * CGFloat(cos(Double(i) * angle)) - fontSize/2
            NSAttributedString(string: "\(i)", attributes:attributes).draw(at: CGPoint(x:x,y:y))
        }
    }
    
    func drawNeedle(width: CGFloat, length: CGFloat, radian: Double, context: CGContext) {
        let midX = self.contentFrame.midX
        let midY = self.contentFrame.midY
        context.move(to: CGPoint(x:midX,y:midY))
        context.setLineWidth(width)
        let dx = length * CGFloat(sin(radian))
        let dy = -length * CGFloat(cos(radian))
        context.addLine(to: CGPoint(x: midX + dx, y: midY+dy))
        context.strokePath()
    }
    
    func animation() {
        self.animate(withDuration: 0.5, animations: {
            self.draw()
            self.animation()
        })
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // MARK: - WCSession delegate methods
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        let manager = FileManager.default
        if let dir = manager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = dir.appendingPathComponent("clocks.txt")
            do {
                try manager.removeItem(at: filePath)
                try manager.copyItem(at: file.fileURL, to: filePath)
            } catch {
                print("cant write file")
            }
            self.clocks = self.parse(url: filePath)
        }
    }
    
    func parse(url: URL) -> [Clock] {
        var result : [Clock] = []
        do {
            let text = try String(contentsOf: url, encoding: String.Encoding.utf8)
            let lines = text.components(separatedBy: "\n")
            let data = lines[0..<(lines.count-1)].map {
                str in return str.components(separatedBy: "\t")
            }
            
            for var datum in data {
                if
                    let ampmValue = Int(datum[1]),
                    let ampm = Ampm(rawValue: ampmValue),
                    let hours = Int(datum[2]),
                    let minutes = Int(datum[3]),
                    let seconds = Int(datum[4]),
                    let dialFromOne = Bool(datum[5]),
                    let clockwise = Bool(datum[6]) {
                    result.append(Clock(name: datum[0],
                                        ampm: ampm,
                                        hours: hours,
                                        minutes: minutes,
                                        seconds: seconds,
                                        dialFromOne: dialFromOne,
                                        clockwise: clockwise))
                }
            }
        } catch {
            print("cant parse file")
        }
        return result
    }
}
