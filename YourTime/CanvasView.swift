//
//  CanvasView.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/06/26.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    var angle = 0

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        UIColor(red: 64 / 255, green: 120 / 255, blue: 192 / 255, alpha: 1).setFill()
        let midX = self.bounds.midX
        let midY = self.bounds.midY
        let path = UIBezierPath()
        path.move(to: CGPoint(x: midX, y: midY))
        let radian = Double(self.angle) / 180.0 * Double.pi
        path.addLine(to: CGPoint(x: midX + midX * CGFloat(cos(radian)), y: midY + midX * CGFloat(sin(radian))))
        path.stroke()
    }
}
