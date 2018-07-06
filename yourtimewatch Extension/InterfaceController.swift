//
//  InterfaceController.swift
//  yourtimewatch Extension
//
//  Created by Kensaku Tanaka on 2018/07/06.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var image: WKInterfaceImage!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let width = self.contentFrame.width
        let height = self.contentFrame.height
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        if let context : CGContext = UIGraphicsGetCurrentContext() {
            context.setFillColor(UIColor.white.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: width, height: height))
            context.setStrokeColor(UIColor.black.cgColor)
            context.beginPath()
            context.move(to: CGPoint(x:0,y:0))
            context.addLine(to: CGPoint(x:width,y:height))
            context.strokePath()
            NSAttributedString(string: "hello").draw(at: CGPoint(x:50,y:50))
            if let cgImage:CGImage = context.makeImage() {
                let uiImage = UIImage(cgImage: cgImage)
                UIGraphicsEndImageContext()
                image.setImage(uiImage)
            }
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
