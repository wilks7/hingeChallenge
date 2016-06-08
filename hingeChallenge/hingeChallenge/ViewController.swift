//
//  ViewController.swift
//  hingeChallenge
//
//  Created by wilksmac on 6/8/16.
//  Copyright © 2016 wilksmac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //testing json
        JsonController.fetchPhotos { (photos, error) in
            if let photos = photos {
                for p in photos {
                    print(p.name)
                }
            }
        }
    }

}

