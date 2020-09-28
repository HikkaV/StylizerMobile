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
    var styleImage : UIImageView? {get}
    var subjectImage : UIImageView? {get}
    var transformButton: UIButton? {get}
    var placeholderForOriginalImage: UIImageView?{get}
    var placeholderForStyleImage:UIImageView?{get}
}

public class MainVCPresenter: NSObject{
    
    var iterator: Iterator = Iterator()
    
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
    }
    
    
    private func addTargets(){
        self.viewController?.subjectImage?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainVCPresenter.didTapSubjectImage)))
        self.viewController?.styleImage?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainVCPresenter.didTapStyleImage)))
        self.viewController?.transformButton?.addTarget(self, action: #selector(MainVCPresenter.didTapTransform), for: .touchUpInside)
        self.viewController?.placeholderForOriginalImage?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainVCPresenter.didTapSubjectImage)))
        self.viewController?.placeholderForStyleImage?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainVCPresenter.didTapStyleImage)))
        
    }
    
    private func selectImageWithPicker(completion: @escaping (UIImage) -> Void){
        if let vc = self.viewController{
            ImagePickerFactory().pickImage(vc) { (image) in
                completion(image)
            }
        }
    }
    
    @objc private func didTapSubjectImage(){
        self.selectImageWithPicker { [weak self] (image) in
            DispatchQueue.main.async {
                 self?.viewController?.subjectImage?.image = image
            }
        }
    }
    @objc private func didTapStyleImage(){
        self.selectImageWithPicker { [weak self] (image) in
            DispatchQueue.main.async {
                self?.viewController?.styleImage?.image = image
            }
        }
    }
    @objc private func didTapTransform(){
        
        guard checkForEssensialParams() else {return}
        enableTransformButton(false)
        iterator.permormTransormationRequest(originalImage: (viewController?.subjectImage?.image)!, styleImage: (viewController?.styleImage?.image)!) { [weak self] (data) in
            if let img = ImageManager.shared.createImageWithData(data: data){
                ImageDetailedFactory.shared.presentImageDetailedController(on: self?.viewController, with: img)
            }else{
                ErrorMessageFactory.shared.showErrorMessage(on: self?.viewController, error: .StylingError)
            }
            self?.enableTransformButton(true)
        }
    }
    
    private func enableTransformButton(_ enable: Bool){
        DispatchQueue.main.async {
            self.viewController?.transformButton?.isEnabled = enable
        }
    }
    
    private func checkForEssensialParams()-> Bool{
        
        guard viewController?.subjectImage?.image != nil else {
            ErrorMessageFactory.shared.showErrorMessage(on: self.viewController, error: .OriginalImageNotSet)
            return false
        }
        guard viewController?.styleImage?.image != nil else {
            ErrorMessageFactory.shared.showErrorMessage(on: self.viewController, error: .StyleImageNotSet)
            return false
        }
        guard NetworkConnectionService.isConnectedToNetwork() else {
            ErrorMessageFactory.shared.showErrorMessage(on: self.viewController, error: .NetworkConnectionError)
            return false
        }
        return true
    }
}
