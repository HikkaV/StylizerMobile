//
//  RequestService.swift
//  StylizerApp
//
//  Created by Dima on 18.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation

import UIKit
private enum errors: Error{
    case noURLSet
    case networkError
    case badResponce
    case noDataToSend
}
   
extension errors : LocalizedError{
       
    public var errorDescription: String?{
        switch self {
        case .noURLSet:
            return NSLocalizedString("no URL Set", comment: "no URL Set")
        case .networkError:
            return NSLocalizedString("network Error", comment: "network Error")
        case .badResponce:
            return NSLocalizedString("server Error", comment: "server Error")
        case .noDataToSend:
            return NSLocalizedString("no data to send", comment: "no data to send Error")
        }
    }
}
public class RequestService {

    public typealias Completion = (_ data: Data?, _ error : Error?)->Void
    
    static let shared = RequestService()
    
    private init(){
        
    }
    
    public func makeRequest(data: Data, url: String, completion: Completion?){
        
        guard let url = URL(string: url) else{
            completion?(nil, errors.noURLSet)
            return
        }
        let request = createRequest(url: url, data: data)
        startDataTask(request: request) { (data, err) in
            completion?(data, err)
        }
        
    }
    
    private func startDataTask(request: URLRequest, completion: Completion?){
        let task = URLSession.shared.dataTask(with: request){ data, responce, error in
            
            if let err = error{
                print(err.localizedDescription)
            }
            
            if let responce = responce as? HTTPURLResponse{
                let goodResponceStatus = (200...299)
                if !(goodResponceStatus.contains(responce.statusCode)) {
                    completion?(nil, errors.badResponce)
                }
                print(responce)
            }
            if let data = data {
                completion?(data, nil)
            }
        }
        task.resume()
        
    }
    
    private func createRequest(url: URL, data: Data)-> URLRequest{
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = data
        request.httpMethod = "POST"
        return request
    }
}
