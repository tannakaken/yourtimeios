//
//  CanvasView.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/06/26.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    var clock : Clock = Clock.defaultClock()
    private var hour : Double = 0.0
    private var minute : Int = 0
    private var second : Int = 0

    override func draw(_ rect: CGRect) {
        // Drawing code
        UIColor(red: 64 / 255, green: 120 / 255, blue: 192 / 255, alpha: 1).setFill()
        let hourLength = self.bounds.midX * 0.5
        let hourUnitAngle = self.unitAngle(totalNum: clock.hours)
        let hourRadian = clock.sig * self.hour * hourUnitAngle
        self.drawNeedle(width: CGFloat(3.0), length: hourLength, radian: hourRadian)
        
        let minuteLength = self.bounds.midX * 0.6
        let minuteUnitAngle = self.unitAngle(totalNum: clock.minutes)
        let minuteRadian = clock.sig * Double(self.minute) * minuteUnitAngle
        self.drawNeedle(width: CGFloat(1.5), length: minuteLength, radian: minuteRadian)
        
        let secondLength = self.bounds.midX * 0.8
        let secondUnitAngle = self.unitAngle(totalNum: clock.seconds)
        let secondRadian = clock.sig * Double(self.second) * secondUnitAngle
        self.drawNeedle(width: CGFloat(0.8), length: secondLength, radian: secondRadian)
        drawDial()
    }
    
    private func unitAngle(totalNum: Int) -> Double {
        return 2.0 / Double(totalNum) * Double.pi
    }
    
    func ticktack(millisecond: CLong) {
        let time = self.clock.calc(time: millisecond)
        self.hour = time.hour
        self.minute = time.minute
        self.second = time.second
    }
    
    private func drawNeedle(width: CGFloat, length: CGFloat, radian: Double) {
        let midX = self.bounds.midX
        let midY = self.bounds.midY
        let path = UIBezierPath()
        path.move(to: CGPoint(x: midX, y: midY))
        path.lineWidth = width
        let dx = length * CGFloat(sin(radian))
        let dy = -length * CGFloat(cos(radian))
        path.addLine(to: CGPoint(x: midX + dx, y: midY + dy))
        path.stroke()
    }
    
    private func drawDial() {
        let fontSize = CGFloat(10)
        let attributes: [NSAttributedStringKey : AnyObject] = [
            .font: UIFont.systemFont(ofSize: fontSize)
        ]
        let radius = self.bounds.midX * 0.9
        let angle = self.clock.sig * self.unitAngle(totalNum: self.clock.hours)
        let range = self.clock.dialFromOne ? 1...self.clock.hours : 0...(self.clock.hours-1)
        for i in range {
            let x = self.bounds.midX + radius * CGFloat(sin(Double(i) * angle)) - fontSize/2
            let y = self.bounds.midY - radius * CGFloat(cos(Double(i) * angle)) - fontSize/2
            "\(i)".draw(at: CGPoint(x:x, y:y), withAttributes: attributes)
        }
    }
}
