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
    
    let queue = DispatchQueue.global(qos: .userInteractive)
    
    func permormTransormationRequest(originalImage: UIImage, styleImage: UIImage, completion :  @escaping (Data?) -> Void){
        queue.async {
            if let data = ImageManager.shared.createDataWithImages(originalImage: originalImage, styleImage: styleImage){
                RequestService.shared.makeRequest(data: data, url: Constants.serverAdress) { (data, _) in
                    if let data = data{
                        completion(data)
                    }else{
                        completion(nil)
                    }
                }
            }else{
                completion(nil)
            }
        }
    }
    
}
