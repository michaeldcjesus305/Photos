//
//  PhotoManager.swift
//  Photos
//
//  Created by michael on 8/7/17.
//  Copyright © 2017 Michael. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire

final class PhotoDataManager {
    
    //MARK: -  Properties
    
    private let baseURL : URL
    
    
    //MARK: Constructors
    
    init(baseURL : URL){
        self.baseURL = baseURL
    }
    
    
    //MARK: Request Functions
    
    func requestPhotos(_ completion: @escaping ((_ success: Bool)->())){
        
        Alamofire.request(baseURL)
            .validate()
            .responseJSON { response in
                
                switch response.result{
                    
                case .success(let json):
                    
                    print("requestPhotos().Success: \(json)")
                    
                    if let photosJSON = json as? [[String : AnyObject]]{
                        
                        var photos = [PhotoModel]()
                        
                        for index in 0...photosJSON.count - 1 {
                            let photoJSON = photosJSON[index]
                            
                            let photo = PhotoModel(photoJSON: photoJSON)
                            photos.append(photo)
                            print(photoJSON)
                            
                        }
                        
                        self.persistPhotosList(photos)
                    }
                    
                    completion(true)
                    
                case .failure(let error):
                    print("PhotoDataManager.requestPhotos().Failure: \(error)")
                    
                    completion(false)
                }
                
        }
        
    }
    
    func requestImageData(imageURL : URL, _ completion: @escaping ((_ success: Bool, _ data : Data?)->())){
        Alamofire.request(imageURL)
        .validate()
        .responseData { response in
            switch response.result {
            case .success(let data):
                print("PhotoDataManager.requestImageData().Success")
                completion(true, data)
            case .failure(let error):
                print("PhotoDataManager.requestImageData().Failure: \(error)")
                
                completion(false, nil)
            }
        }
    }
    
    //MARK: Persistence Fuctions
    
    fileprivate func persistPhotosList(_ photoList : [PhotoModel]){
        let realm = try! Realm()
        
        try! realm.write {
            for photo in photoList {
                realm.add(photo, update: true)
            }
        }
    }
    
    //MARK: Database Query Functions
    
    func getPhotos() -> List<PhotoModel>{
        let realm = try! Realm()
        
        let photoList = List<PhotoModel>()
        
        let photosResult = realm.objects(PhotoModel.self).sorted(byKeyPath: "albumId").sorted(byKeyPath: "albumId")
        
        photoList.append(objectsIn: photosResult)
        
        return photoList
    }
    
    func getAlbuns() -> [Int] {
        let realm = try! Realm()
        
        let albuns : [Int] = Array(Set(realm.objects(PhotoModel.self).value(forKey: "albumId") as! [Int])).sorted()
        
        return albuns
    }
    
}

