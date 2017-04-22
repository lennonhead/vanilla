//
//  UIButton+Custom.swift
//  vanilla
//
//  Created by Matthew Folsom on 4/21/17.
//  Copyright © 2017 mattfolsom. All rights reserved.
//

import UIKit

extension UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
