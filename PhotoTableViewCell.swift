//
//  PhotoTableViewCell.swift
//  Photos
//
//  Created by michael on 09/08/17.
//  Copyright © 2017 Michael. All rights reserved.
//

import UIKit

class PhotoTableViewCell : UITableViewCell {
    
    //MARK: Outlets
    
    @IBOutlet weak var photoTitleLabel  : UILabel!
    @IBOutlet weak var photoImageView   : UIImageView!
    
    //MARK: Cell Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
