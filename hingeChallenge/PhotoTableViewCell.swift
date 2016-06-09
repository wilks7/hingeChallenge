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
    
}
