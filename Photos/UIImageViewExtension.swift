//
//  UIImageView.swift
//  Photos
//
//  Created by michael on 09/08/17.
//  Copyright © 2017 Michael. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func loadImageFromUrlUsingCache(_ urlText : String) {
        
        let photoDataManager = {
            return PhotoDataManager(baseURL: API.BaseURL!)
        }()
        
        let url = URL(string: urlText)
        
        self.image = nil
        
        //verify if imageView has cache of image
        if let cachedImage = imageCache.object(forKey: urlText as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // download image from url
        photoDataManager.requestImageData(imageURL: url!){success, data in
            if(success){
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlText as NSString)
                    self.image = image
                }
            }
        }
        
    }
}
