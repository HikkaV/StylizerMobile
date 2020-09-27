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
    @IBOutlet weak var buttonTransform: UIButton?
    
    @IBOutlet weak var originalPlaceHolderView: UIImageView?
    @IBOutlet weak var stylePlaceHolderView: UIImageView?
    
    var presenter: MainVCPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
        configUI()
       
    }
    
    private func initPresenter(){
        self.presenter = MainVCPresenter()
        self.presenter?.viewController = self
    }
    
    private func configUI(){
        originalImageView?.layer.cornerRadius = 32
        styleImageView?.layer.cornerRadius = 32
        buttonTransform?.layer.cornerRadius = 16
        GradientTool.createGradientOnView(view: self.view.superview ?? self.view)
        
    }

}
extension MainViewController: MainVCPresenterViewController{
    
    var placeholderForOriginalImage: UIImageView? {
        return originalPlaceHolderView
    }
    
    var placeholderForStyleImage: UIImageView? {
        return stylePlaceHolderView
    }
    
    
    var transformButton: UIButton? {
        return buttonTransform
    }
    
    var styleImage: UIImageView? {
        return styleImageView
    }
    
    var subjectImage: UIImageView? {
        return originalImageView
    }
    
}

