//
//  ImageDetailsController.swift
//  StylizerApp
//
//  Created by Dima on 26.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class ImageDetailsController: UIViewController {
    
    @IBOutlet weak var image: UIImageView?
    @IBOutlet weak var dismissButton: UIButton?
    @IBOutlet weak var saveButton: UIButton?
    
    var presenter: ImageDetailsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    private func configUI(){
        GradientTool.createGradientOnView(view: self.view)
        dismissButton?.layer.cornerRadius = 16
        saveButton?.layer.cornerRadius = 16
    }
}

extension ImageDetailsController: DetailsImagePresenterController{
    
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

