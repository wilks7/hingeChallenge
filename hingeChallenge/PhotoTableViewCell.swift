//
//  PhotoTableViewCell.swift
//  hingeChallenge
//
//  Created by wilksmac on 6/8/16.
//  Copyright © 2016 wilksmac. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameOutlet: UILabel!
    
    @IBOutlet weak var descriptionOutlet: UILabel!
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    func setupCell(photo: Photo){
        nameOutlet.text = photo.name
        descriptionOutlet.text = photo.description
        imageOutlet.image = photo.image
    }
    
    func roundImage(){
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.imageOutlet.layer.cornerRadius = self.imageOutlet.frame.size.width / 2
            self.imageOutlet.layer.borderWidth = 1.50
            self.imageOutlet.layer.borderColor = UIColor.blueColor().CGColor
            self.imageOutlet.clipsToBounds = true
            self.imageOutlet.layer.masksToBounds = true
            self.imageOutlet.alpha = 1
        }
    }
}
