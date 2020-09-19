//
//  ViewController.swift
//  StylizerApp
//
//  Created by Dima on 16.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var presenter: MainVCPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
    }
    
    private func initPresenter(){
        self.presenter = MainVCPresenter()
        self.presenter?.viewController = self
    }

}
extension MainViewController: MainVCPresenterViewController{
    var styleImage: UIImageView? {
        return nil
    }
    
    var subjectImage: UIImageView? {
        return nil
    }
}

