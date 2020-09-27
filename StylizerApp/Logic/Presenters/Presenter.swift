//
//  Presenter.swift
//  StylizerApp
//
//  Created by Dima on 26.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation
import UIKit

public protocol Presenter {
    
    var viewController: UIViewController?{get set}
    
    func connectToViewController()
}
