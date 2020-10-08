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
    var buttonShare: UIButton?{get}
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
        viewController?.buttonDismiss?.addTarget(self, action: #selector(ImageDetailsPresenter.didTapDismissButton), for: .touchUpInside)
        viewController?.buttonSave?.addTarget(self, action: #selector(ImageDetailsPresenter.didTapSaveButton), for: .touchUpInside)
        viewController?.buttonShare?.addTarget(self, action: #selector(ImageDetailsPresenter.didTapShareButton), for: .touchUpInside)
    }
    
    @objc private func didTapShareButton(){
        if let img = viewController?.stylizedImage?.image{
            DispatchQueue.main.async {
                ImageManager.shared.presentImageSharingOnVC(image: img, vc: self.viewController)
            }
        }
    }
    
    @objc private func didTapSaveButton(){
        if let img = viewController?.stylizedImage?.image{
            DispatchQueue.main.async {
                ImageManager.shared.saveImage(image: img)
            }
        }
    }
    
    @objc private func didTapDismissButton(){
        self.viewController?.dismiss(animated: true, completion: nil)
    }
    
}
