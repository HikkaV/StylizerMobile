//
//  ImageManger.swift
//  StylizerApp
//
//  Created by Dima on 18.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation

import UIKit

public class ImageManager{
    
    static let shared = ImageManager()
    private init(){}
    
    public func createDataWithImages(originalImage: UIImage, styleImage: UIImage) -> Data?{
        let originalImageData = originalImage.resizedTo1MB()?.pngData()?.base64EncodedString()
        let styleImageData = styleImage.resizedTo1MB()?.pngData()?.base64EncodedString()
        let dict = [Constants.keyOriginalImage : originalImageData, Constants.keyStyleImage: styleImageData]
        if let data = try? JSONSerialization.data(withJSONObject: dict, options: []){
            return data
        }else{
            return nil
        }
    }
    
    public func createImageWithData(data: Data?) -> UIImage?{
        guard let data = data else {
            return nil
        }
        if let encodedString = String(bytes: data, encoding: .utf8), let imgData =  Data(base64Encoded: encodedString, options: .ignoreUnknownCharacters), let image = UIImage(data: imgData){
            return image
        }
        return nil
    }
    
    public func saveImage(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    public func presentImageSharingOnVC(image: UIImage, vc: UIViewController?){
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = vc?.view
        vc?.present(activityViewController, animated: true, completion: nil)
    }
}
