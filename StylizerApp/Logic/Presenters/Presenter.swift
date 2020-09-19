//
//  Presenter.swift
//  StylizerApp
//
//  Created by Dima on 16.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation

public protocol Presenter {
    func connectToViewController()
    var iterator: Iterator { get set }
}
