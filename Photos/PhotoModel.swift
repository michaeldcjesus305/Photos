//
//  PhotoModel.swift
//  Photos
//
//  Created by michael on 8/7/17.
//  Copyright © 2017 Michael. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoModel : Object{
    
    //MARK: Properties
    
    dynamic var photoId = 0
    dynamic var title  = ""
    dynamic var url = ""
    dynamic var thumbnailUrl = ""
    dynamic var albumId = 0 
    
    //MARK: Realm functions
    
    override static func primaryKey() -> String? {
        return "photoId"
    }
    
    //MARK: Constructors
    
    convenience init(photoJSON : Dictionary<String, AnyObject>){
        self.init()
        
        self.photoId = photoJSON["id"] as? Int ?? 0
        self.title = photoJSON["title"] as? String ?? ""
        self.url = photoJSON["url"] as? String ?? ""
        self.thumbnailUrl = photoJSON["thumbnailUrl"] as? String ?? ""
        self.albumId = photoJSON["albumId"] as? Int ?? 0
    }
    
}
