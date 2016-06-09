//
//  GalleryViewController.swift
//  hingeChallenge
//
//  Created by wilksmac on 6/8/16.
//  Copyright © 2016 wilksmac. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    @IBOutlet weak var titleOutlet: UILabel!
    
    @IBOutlet var myView: UIView!
    
    var place = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func slideShow(){
            if place == PhotoController.sharedController.allPhotos.count - 1{
                place = 0
            } else {
                place++
            }
            //sleep(2)
            let photo = PhotoController.sharedController.allPhotos[self.place]
            
            self.updateView(photo, place: self.place, total: PhotoController.sharedController.allPhotos.count)
    }
    
    func updateView(photo: Photo, place: Int, total: Int){
        self.place = place
        imageViewOutlet.image = photo.image
        titleOutlet.text = photo.name
        title = "\(place+1)/\(total)"
    }
    
    //testing slideshow with button press
    @IBAction func buttonPressed(sender: AnyObject) {
        slideShow()
    }
    
}
