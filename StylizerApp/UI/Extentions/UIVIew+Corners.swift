//
//  UIVIew+Corners.swift
//  StylizerApp
//
//  Created by Dima on 08.10.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

extension UIView {

    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }

}
