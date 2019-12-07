//
//  File.swift
//  PicGrabber
//
//  Created by Shekhar Gupta on 06/12/19.
//  Copyright © 2019 Shekhar. All rights reserved.
//

import UIKit

class PGNetworkManager: NSObject {
    
    static let shared = PGNetworkManager()
    
    static let errorMessage = "Something went wrong, Please try again later"
    static let noInternetConnection = "Please check your Internet connection and try again."
    
    func request(_ request: PGRequest, completion: @escaping (PGResult<Data>) -> Void) {
        guard (PGReachability.currentReachabilityStatus != .notReachable) else {
            return completion(.Failure(PGNetworkManager.noInternetConnection))
        }
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard error == nil else {
                return completion(.Failure(error!.localizedDescription))
            }
            guard let data = data else {
                return completion(.Failure(error?.localizedDescription ?? PGNetworkManager.errorMessage))
            }
            guard String(data: data, encoding: String.Encoding.utf8) != nil else {
                return completion(.Failure(error?.localizedDescription ?? PGNetworkManager.errorMessage))
            }
            return completion(.Success(data))
            
        }.resume()
    }
    
    func downloadImage(_ urlString: String, completion: @escaping (PGResult<UIImage>) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        guard let url =  URL.init(string: urlString) else {
            return completion(.Failure(PGNetworkManager.errorMessage))
        }
        guard (PGReachability.currentReachabilityStatus != .notReachable) else {
            return completion(.Failure(PGNetworkManager.noInternetConnection))
        }
        session.downloadTask(with: url) { (url, reponse, error) in
            do {
                guard let url = url else {
                    return completion(.Failure(PGNetworkManager.errorMessage))
                }
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    return completion(.Success(image))
                } else {
                    return completion(.Failure(PGNetworkManager.errorMessage))
                }
            } catch {
                return completion(.Error(PGNetworkManager.errorMessage))
            }
            }.resume()
    }
}
