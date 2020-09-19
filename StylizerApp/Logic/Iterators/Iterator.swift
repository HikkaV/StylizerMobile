//
//  Iterator.swift
//  StylizerApp
//
//  Created by Dima on 16.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation
import UIKit

public class Iterator{
    
    func permormTransormationRequest(originalImage: UIImage, styleImage: UIImage, completion :  @escaping (Data?, Error?) -> Void){
        if let data = ImageManager.shared.createDataWithImages(originalImage: originalImage, styleImage: styleImage){
            RequestService.shared.makeRequest(data: data, url: Constants.serverAdress) { (data, err) in
                completion(data, err)
            }
        }else{
            completion(nil, nil)
        }
       
        
    }
    
}
