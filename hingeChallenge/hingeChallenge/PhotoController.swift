//
//  PhotoController.swift
//  hingeChallenge
//
//  Created by wilksmac on 6/8/16.
//  Copyright © 2016 wilksmac. All rights reserved.
//

import Foundation
import UIKit

class PhotoController {
    
    static let sharedController = PhotoController()
    
    var allPhotos = [Photo]()
    
    //pull photo from urlString
    func getPhoto(photo: Photo, completion:(image: UIImage) -> Void) {
        
        let urlString = photo.imgUrlString
        
        ImageLoader.sharedLoader.imageForUrl(urlString) { (image, url) in
        
            if let image = image {
                completion(image: image)
            } else {
                completion(image: UIImage(named: "noImage")!)
            }
        }
    }
    
    //slower network method testing not sure if it is more optimal
    func photosFromUrl(urlStringArray: [String], completion:(images: [UIImage])->Void){
        var allImages = [UIImage]()
        let dispatchGroup = dispatch_group_create()
        
        for s in urlStringArray {
            dispatch_group_enter(dispatchGroup)
            
            guard let url = NSURL(string: s) else {return}
            
            if let data = NSData(contentsOfURL: url){
                if let image = UIImage(data: data){
                    allImages.append(image)
                } else {
                    allImages.append(UIImage(named: "noImage")!)
                }
            } else {
                allImages.append(UIImage(named: "noImage")!)
            }
            
            dispatch_group_leave(dispatchGroup)
        }//for
        
        dispatch_group_notify(dispatchGroup, dispatch_get_main_queue()) { () -> Void in
            completion(images: allImages)
        }
    }
    
}