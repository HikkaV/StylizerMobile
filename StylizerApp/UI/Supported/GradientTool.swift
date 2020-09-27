//
//  GradientTool.swift
//  StylizerApp
//
//  Created by Dima on 26.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation
import UIKit

public class GradientTool {
    class func createGradientOnView(view: UIView) {
        let layer = CAGradientLayer()
        layer.colors = [
          UIColor(red: 0.455, green: 0.2, blue: 1, alpha: 1).cgColor,
          UIColor(red: 1, green: 0.639, blue: 0.992, alpha: 1).cgColor
        ]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer.bounds = view.bounds.insetBy(dx: -0.6*view.bounds.size.width, dy: -0.6*view.bounds.size.height)
        layer.position = view.center
        view.layer.insertSublayer(layer, at: 0)
    }
}
