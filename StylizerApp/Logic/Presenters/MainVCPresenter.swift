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
        addObservers()
    }
    
    private func addObservers(){
        [self.viewController?.subjectImage, self.viewController?.styleImage].forEach({$0?.addObserver(self, forKeyPath: "image", options: .new, context: nil)})
    }
    
    private func addTargets(){
        self.viewController?.subjectImage?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainVCPresenter.didTapSubjectImage)))
        self.viewController?.styleImage?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainVCPresenter.didTapStyleImage)))
        self.viewController?.transformButton?.addTarget(self, action: #selector(MainVCPresenter.didTapTransform), for: .touchUpInside)
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
        guard let styleIMG = viewController?.styleImage?.image,let originalIMG = viewController?.subjectImage?.image else {return}
        iterator.permormTransormationRequest(originalImage: styleIMG, styleImage: originalIMG) { [weak self] (data, err)  in
            
        }
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Constants.stringImage && viewController?.styleImage?.image != nil && viewController?.subjectImage?.image != nil{
            viewController?.transformButton?.isEnabled = true
        }else{
            viewController?.transformButton?.isEnabled = false
        }
    }
}
