//
//  DetailedImagePresenter.swift
//  StylizerApp
//
//  Created by Dima on 26.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation
import UIKit

public protocol DetailsImagePresenterController where Self: UIViewController{
    var buttonSave: UIButton?{get}
    var buttonDismiss: UIButton?{get}
    var stylizedImage: UIImageView?{get}
}

public class ImageDetailsPresenter: NSObject{
    
    weak var viewController: DetailsImagePresenterController?{
        didSet{
            self.connectToViewController()
        }
    }
    
    private func connectToViewController(){
        self.addTargets()
    }
    
    private func addTargets(){
        viewController?.buttonDismiss?.addTarget(self, action: #selector(ImageDetailsPresenter.didTapSaveButton), for: .touchUpInside)
        viewController?.buttonSave?.addTarget(self, action: #selector(ImageDetailsPresenter.didTapSaveButton), for: .touchUpInside)
    }
    
    @objc private func didTapSaveButton(){
        if let img = viewController?.stylizedImage?.image{
            ImageManager.shared.saveImage(image: img)
        }
    }
    
    @objc private func didTapDismissButton(){
        self.viewController?.dismiss(animated: true, completion: nil)
    }
    
}
