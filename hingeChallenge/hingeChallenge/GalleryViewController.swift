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
    
    @IBOutlet var myView: UIView!
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    var index = 0
    
    var myTimer: NSTimer?
    
    var slideShowStatus = false
    
    
    @IBAction func trashButtonTapped(sender: AnyObject) {
        self.imageViewOutlet.stopAnimating()
        myTimer?.invalidate()
        let photo = PhotoController.sharedController.allPhotos[self.index - 1]
        self.imageViewOutlet.image = photo.image
        slideShowStatus = false
        buttonOutlet.setTitle("Start Slideshow", forState: .Normal)

        let alert = UIAlertController(title: "Erase", message: "Are you sure you would like to erase '\(photo.name)' photo?", preferredStyle: .Alert)
        let erase = UIAlertAction(title: "Erase", style: .Destructive) { (_) in
            PhotoController.sharedController.allPhotos.removeAtIndex(self.index - 1)
            if self.index > 2 {
                self.imageViewOutlet.image = PhotoController.sharedController.allPhotos[self.index - 2].image
            } else if self.index == 0{
                self.imageViewOutlet.image = PhotoController.sharedController.allPhotos[self.index+1].image
            } else if self.index == 1{
                self.imageViewOutlet.image = PhotoController.sharedController.allPhotos[self.index - 1].image
            }
        }
        let no = UIAlertAction(title: "No", style: .Default, handler: nil)
        alert.addAction(no)
        alert.addAction(erase)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateView(photo: Photo, place: Int, total: Int){
        self.index = place
        imageViewOutlet.image = photo.image
        title = "\(place+1)/\(total)"
    }
    
    func startSlideShow(){
        self.index = 1
        title = "1/\(PhotoController.sharedController.allPhotos.count)"
        slideShowStatus = true
        var imageArray = [UIImage]()
        for p in PhotoController.sharedController.allPhotos {
            
            let image = p.image
            imageArray.append(image)
        }
        
        self.imageViewOutlet.animationImages = imageArray
        self.imageViewOutlet.animationDuration = 30.0
        self.imageViewOutlet.startAnimating()
        myTimer = NSTimer.scheduledTimerWithTimeInterval(2.3, target: self, selector: "displayTitle", userInfo: nil, repeats: true)
        
    }
    
    func displayTitle(){
        title = "\(self.index+1)/\(PhotoController.sharedController.allPhotos.count)"
        index++
        if self.index == PhotoController.sharedController.allPhotos.count {
            index = 0
        }
    }
    
    //testing slideshow with button press
    @IBAction func buttonPressed(sender: AnyObject) {
        if slideShowStatus {
            self.imageViewOutlet.stopAnimating()
            myTimer?.invalidate()
            if index != 0 {
                self.imageViewOutlet.image = PhotoController.sharedController.allPhotos[self.index - 1].image
            } else {
                self.imageViewOutlet.image = PhotoController.sharedController.allPhotos[self.index].image
            }
            slideShowStatus = false
            buttonOutlet.setTitle("Start Slideshow", forState: .Normal)
        } else {
            startSlideShow()
            buttonOutlet.setTitle("Stop Slideshow", forState: .Normal)
        }
        
    }
    
}
