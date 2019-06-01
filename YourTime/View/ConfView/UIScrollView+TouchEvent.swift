//
//  UIScrollView+TouchEvent.swift
//  YourTime
//
//  Created by 田中健策 on 2019/06/01.
//  Copyright © 2019 Kensaku Tanaka. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event);
    }
}
