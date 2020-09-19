//
//  MainVCPresenter.swift
//  StylizerApp
//
//  Created by Dima on 16.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation
import UIKit

public protocol MainVCPresenterViewController where Self: UIViewController {
    var styleImage : UIImageView?{get}
    var subjectImage : UIImageView?{get}
}

public class MainVCPresenter{
    
    weak var viewController: MainVCPresenterViewController?{
        didSet{
            self.connectToViewController()
        }
    }
    
    convenience init(for vc: MainVCPresenterViewController) {
        self.init()
        self.viewController = vc
    }
    
    private func connectToViewController(){
        addTargets()
        addObservers()
    }
    
    private func addObservers(){
        
    }
    
    private func addTargets(){
        
    }
    
}
