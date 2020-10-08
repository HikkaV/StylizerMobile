//
//  ErrorMessageFactory.swift
//  StylizerApp
//
//  Created by Dima on 27.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation
import UIKit

public class ErrorMessageFactory{
    
    private init(){}
    
    static let shared = ErrorMessageFactory()
    
    enum ErrorType: String {
        case StyleImageNotSet = "Please choose style image!"
        case OriginalImageNotSet = "Please choose original image!"
        case NetworkConnectionError = "You are not connected to network!"
        case StylingError = "Failed to stylize your image!"
    }
    
    func showErrorMessage(on vc: UIViewController?, error type: ErrorType){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: R.string.localizable.alertTitleWarning(), message: type.rawValue, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: R.string.localizable.alertActionDismiss(), style: .cancel, handler: nil)
            alert.addAction(alertAction)
            vc?.present(alert, animated: true, completion: nil)
        }
    }
}

