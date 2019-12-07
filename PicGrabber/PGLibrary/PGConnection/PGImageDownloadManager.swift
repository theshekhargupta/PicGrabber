//
//  PGImageDownloadManager.swift
//  PicGrabber
//
//  Created by Shekhar Gupta on 06/12/19.
//  Copyright © 2019 Shekhar. All rights reserved.
//

import UIKit

typealias ImageClosure = (_ result: PGResult<UIImage>, _ url: String) -> Void

class PGImageDownloadManager: NSObject {
    
    static let shared = PGImageDownloadManager()
    
    private var operationQueue = OperationQueue()
    private var dictionaryBlocks = [UIImageView: (String, ImageClosure, PGImageDownloadOperation)]()
    
    private override init() {
        operationQueue.maxConcurrentOperationCount = 100
    }
    
    func addOperation(url: String, imageView: UIImageView, completion: @escaping ImageClosure) {
        if let image = PGDataCache.shared.getImageFromCache(key: url)  {
            completion(.Success(image), url)
            if let tupple = self.dictionaryBlocks.removeValue(forKey: imageView){
                tupple.2.cancel()
            }
        } else {
            if !checkOperationExists(with: url,completion: completion) {
            
                if let tupple = self.dictionaryBlocks.removeValue(forKey: imageView){
                    tupple.2.cancel()
                }
                
                let newOperation = PGImageDownloadOperation(url: url) { (image,downloadedImageURL) in
                    if let tupple = self.dictionaryBlocks[imageView] {
                        if tupple.0 == downloadedImageURL {
                            if let image = image {
                                PGDataCache.shared.saveImageToCache(key: downloadedImageURL, image: image)
                                tupple.1(.Success(image), downloadedImageURL)
                                if let tupple = self.dictionaryBlocks.removeValue(forKey: imageView){
                                    tupple.2.cancel()
                                }
                            } else {
                                tupple.1(.Failure("Not fetched"), downloadedImageURL)
                            }
                            
                            _ = self.dictionaryBlocks.removeValue(forKey: imageView)
                        }
                    }
                }
                
                dictionaryBlocks[imageView] = (url, completion, newOperation)
                operationQueue.addOperation(newOperation)
            }
        }
    }
    
    func checkOperationExists(with url: String, completion: @escaping ImageClosure) -> Bool {
        if let arrayOperation = operationQueue.operations as? [PGImageDownloadOperation] {
            let opeartions = arrayOperation.filter{$0.url == url}
            return opeartions.count > 0 ? true : false
        }
        
        return false
    }
}
