//
//  ImageDetailsController.swift
//  StylizerApp
//
//  Created by Dima on 26.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class ImageDetailsController: UIViewController {
    
    @IBOutlet weak var imagePlaceHolderView: UIView!
    @IBOutlet weak var image: UIImageView?
    @IBOutlet weak var dismissButton: UIButton?
    @IBOutlet weak var saveButton: UIButton?
    @IBOutlet weak var shareButton: UIButton?
    var presenter: ImageDetailsPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        initPresenter()
    }
    
    private func initPresenter(){
        presenter = ImageDetailsPresenter()
        presenter?.viewController = self
    }
    
    private func configUI(){
        GradientTool.createGradientOnView(view: self.view)
        saveButton?.layer.cornerRadius = 16
        [shareButton, dismissButton].forEach({$0?.makeCircleCorners()})
        [imagePlaceHolderView, image].forEach({$0?.layer.cornerRadius = 16})
    }
}

extension ImageDetailsController: DetailsImagePresenterController{
    
    var buttonShare: UIButton?{
        return shareButton
    }
    
    var buttonSave: UIButton? {
        return saveButton
    }
    
    var buttonDismiss: UIButton? {
        return dismissButton
    }
    
    var stylizedImage: UIImageView? {
        return image
    }
    
}

