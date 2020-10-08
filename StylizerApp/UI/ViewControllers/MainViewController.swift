//
//  ViewController.swift
//  StylizerApp
//
//  Created by Dima on 16.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MainViewController: UIViewController {

    @IBOutlet weak var originalImageView: UIImageView?
    @IBOutlet weak var styleImageView: UIImageView?
    @IBOutlet weak var buttonTransform: UIButton?
    
    @IBOutlet weak var originalPlaceHolderView: UIImageView?
    @IBOutlet weak var stylePlaceHolderView: UIImageView?
    
    var presenter: MainVCPresenter?
    var activityView: NVActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
        configUI()
        activityView = NVActivityIndicatorView(frame: buttonTransform?.frame ?? CGRect.zero, type: .ballSpinFadeLoader, color: .appPink, padding: nil)
    }
    
    private func initPresenter(){
        self.presenter = MainVCPresenter()
        self.presenter?.viewController = self
    }
    
    private func configUI(){
        [styleImageView, originalImageView].forEach({$0?.roundCorners([.topLeft, .topRight], radius: 32)})
        buttonTransform?.layer.cornerRadius = 16
        buttonTransform?.setTitle(R.string.localizable.buttonTitleTransform(), for: .normal)
        GradientTool.createGradientOnView(view: self.view.superview ?? self.view)
        
    }

}
extension MainViewController: MainVCPresenterViewController{
    
    func enableLoadingView(_ enable: Bool) {
        DispatchQueue.main.async {
            self.transformButton?.isEnabled = !enable
            enable ? self.transformButton?.setTitle(nil, for: .normal) : self.transformButton?.setTitle(R.string.localizable.buttonTitleTransform(), for: .normal)
            enable ? self.activityView?.startAnimating(): self.activityView?.stopAnimating()
            enable ? self.view.addSubview(self.activityView ?? UIView()) : self.activityView?.removeFromSuperview()
            
        }
    }
    
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

