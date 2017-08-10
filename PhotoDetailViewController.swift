//
//  PhotoDetailViewController.swift
//  Photos
//
//  Created by michael on 09/08/17.
//  Copyright © 2017 Michael. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var photoImageView : UIImageView!
    @IBOutlet weak var closeButton : UIButton!
    
    //MARK: Properties
    
    var photoURL = ""
    
    //MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.loadImageFromUrlUsingCache(photoURL)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        closeButton.addGradientBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: IBActions
    
    @IBAction
    func closeModal(){
        dismiss(animated: true, completion: nil)
    }
    
}
