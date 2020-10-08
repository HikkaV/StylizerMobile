//
//  UIButton+Corners.swift
//  StylizerApp
//
//  Created by Dima on 08.10.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

extension UIButton{
    func makeCircleCorners(){
        self.layer.cornerRadius = self.frame.height/2
    }
}
