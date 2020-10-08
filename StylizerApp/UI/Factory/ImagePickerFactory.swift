//
//  ImagePickerFactory.swift
//  StylizerApp
//
//  Created by Dima on 19.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation
import UIKit

public class ImagePickerFactory: NSObject, UINavigationControllerDelegate{

    var picker = UIImagePickerController();
    var alert = UIAlertController(title: R.string.localizable.alertTitleChoose_Image(), message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?;

    override init(){
        super.init()
    }

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;

        let cameraAction = UIAlertAction(title: R.string.localizable.alertActionCamera(), style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: R.string.localizable.alertActionGalery(), style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: R.string.localizable.alertActionCancel(), style: .cancel){
            UIAlertAction in
        }

        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.viewController?.present(picker, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: R.string.localizable.alertTitleWarning(), message: R.string.localizable.alertMessageNo_Camera(), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: R.string.localizable.alertActionCancel(), style: .cancel, handler: nil))
            self.viewController?.present(alertController, animated: true)
        }
    }
    func openGallery(){
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }


}

extension ImagePickerFactory : UIImagePickerControllerDelegate{
    
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        pickImageCallback?(image)
        picker.dismiss(animated: true, completion: nil)
        
    }
}
