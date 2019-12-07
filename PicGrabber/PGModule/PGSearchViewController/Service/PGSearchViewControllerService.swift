//
//  PGSearchViewControllerService.swift
//  PicGrabber
//
//  Created by Shekhar Gupta on 06/12/19.
//  Copyright © 2019 Shekhar. All rights reserved.
//

import UIKit

class PGSearchViewControllerService: NSObject {
    func request(_ searchText: String, pageNo: Int, completion: @escaping (PGResult<PGPhotos?>) -> Void) {
        guard let request = PGFlickrRequestConfig.searchRequest(searchText, pageNo).value else {
            return
        }
        
        PGNetworkManager.shared.request(request) { (result) in
            switch result {
            case .Success(let responseData):
                if let model = self.processResponse(responseData) {
                    if let stat = model.stat, stat.uppercased().contains("OK") {
                        return completion(.Success(model.photos))
                    } else {
                        return completion(.Failure(PGNetworkManager.errorMessage))
                    }
                } else {
                    return completion(.Failure(PGNetworkManager.errorMessage))
                }
            case .Failure(let message):
                return completion(.Failure(message))
            case .Error(let error):
                return completion(.Failure(error))
            }
        }
    }
    
    func processResponse(_ data: Data) -> PGSearchViewControllerModel? {
        do {
            let responseModel = try JSONDecoder().decode(PGSearchViewControllerModel.self, from: data)
            return responseModel
        } catch {
            print("Data parsing error: \(error.localizedDescription)")
            return nil
        }
    }
}
