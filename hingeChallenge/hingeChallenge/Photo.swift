//
//  Photo.swift
//  hingeChallenge
//
//  Created by wilksmac on 6/8/16.
//  Copyright © 2016 wilksmac. All rights reserved.
//

import Foundation
import UIKit

class Photo {
    
    var name: String
    var description: String
    var imgUrlString: String
    var image: UIImage
    
    init(name: String, description: String, imgUrlString: String, image: UIImage?){
        self.name = name
        self.description = description
        self.imgUrlString = imgUrlString
        if let image = image {
            self.image = image
        } else {
            self.image = UIImage(named: "noImage")!
        }
    }
    
    func setImage(image: UIImage) {
        self.image = image
    }
    
}