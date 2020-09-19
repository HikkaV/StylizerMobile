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
        
        let originalImageData = originalImage.pngData()
        let styleImageData = styleImage.pngData()
        
        let dict = ["originalImage" : originalImageData, "styleImage": styleImageData]
        if let data = try? JSONSerialization.data(withJSONObject: dict, options: []){
            return data
        }else{
            return nil
        }
    }
}
