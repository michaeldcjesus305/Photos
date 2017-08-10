//
//  ViewController.swift
//  Photos
//
//  Created by michael on 8/7/17.
//  Copyright © 2017 Michael. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //MARK: Outlets
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var headerView : UIView!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    @IBOutlet weak var requestErrorLabel : UILabel!
    @IBOutlet weak var tryAgainButton : UIButton!
    
    //MARK: Properties
    
    fileprivate lazy var photoDataManager = {
        return PhotoDataManager(baseURL: API.BaseURL!)
    }()
    
    fileprivate var photos = try! Realm().objects(PhotoModel.self).sorted(byKeyPath: "albumId")
    fileprivate var albuns : [Int] = []
    
    var currentPhotoURL = ""
    
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        requestPhotos()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.addGradientBackground()
        tryAgainButton.addGradientBackground()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoDetailSegue" {
            if let photoDetailViewController = segue.destination as? PhotoDetailViewController {
                photoDetailViewController.photoURL = currentPhotoURL
            }
        }
    }
    
    fileprivate func requestPhotos(){
        activityIndicator.startAnimating()
        
        self.requestErrorLabel.isHidden = true
        self.tryAgainButton.isHidden = true
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.photoDataManager.requestPhotos(){success in
                self.activityIndicator.stopAnimating()
                
                if(success){
                    DispatchQueue.main.async {
                        self.photos = try! Realm().objects(PhotoModel.self).sorted(byKeyPath: "albumId")
                        self.albuns = self.photoDataManager.getAlbuns()
                        self.tableView.isHidden = false
                        
                        self.tableView.reloadData()
                    }
                }else{
                    DispatchQueue.main.async {
                        self.tableView.isHidden = true
                        self.requestErrorLabel.isHidden = false
                        self.tryAgainButton.isHidden = false
                    }
                }
            }
        }
    }
    
    //MARK: TableView Configuration Functions
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return String(self.albuns[section])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentPhoto = photos.filter("albumId == %@", indexPath.section + 1)[indexPath.row]
        currentPhotoURL = currentPhoto.url
        self.performSegue(withIdentifier: "photoDetailSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return photos.filter("albumId == %@", section + 1).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoTableViewCell
        
        let currentPhoto = photos.filter("albumId == %@", indexPath.section + 1)[indexPath.row]
        
        cell.photoTitleLabel.text = currentPhoto.title
        
        cell.photoImageView.loadImageFromUrlUsingCache(currentPhoto.thumbnailUrl)
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return albuns.count
    }
    
    //MARK: IBActions
    
    @IBAction func requestPhotosAction(){
        requestPhotos()
    }
}

