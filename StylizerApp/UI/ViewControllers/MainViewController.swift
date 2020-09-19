//
//  ViewController.swift
//  StylizerApp
//
//  Created by Dima on 16.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var originalImageView: UIImageView?
    @IBOutlet weak var styleImageView: UIImageView?
    
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
    
    var transformButton: UIButton? {
        return nil
    }
    
    var styleImage: UIImageView? {
        return styleImageView
    }
    
    var subjectImage: UIImageView? {
        return originalImageView
    }
}

