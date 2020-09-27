//
//  ImageDetailedFactory.swift
//  StylizerApp
//
//  Created by Dima on 27.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation
import UIKit

public class ImageDetailedFactory {
    
    private init(){}
    public static let shared = ImageDetailedFactory()
    
    func presentImageDetailedController(on vc: UIViewController?, with image: UIImage?){
        DispatchQueue.main.async {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = sb.instantiateViewController(withIdentifier: "ImageDetailsController") as? ImageDetailsController{
                
                vc?.present(viewController, animated: true, completion: {
                    viewController.image?.image = image
                })
            }
        }
    }
}
