//
//  JsonController.swift
//  hingeChallenge
//
//  Created by wilksmac on 6/8/16.
//  Copyright © 2016 wilksmac. All rights reserved.
//

import Foundation
import UIKit

class JsonController {
    
    
    static let urlString = "https://hinge-homework.s3.amazonaws.com/client/services/homework.json"
    
    static func fetchPhotoObjects(completion:(photos: [Photo]?, error: NSError?)->Void){
        
        if let url = NSURL(string: urlString){
            
            let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                // error handling
                if let error = error {
                    completion(photos: nil, error: error)
                }
                
                guard let data = data else {
                    completion(photos: nil, error: nil)
                    return
                }
                
                //json serialization
                let jsonObject: AnyObject
                
                do {
                    jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                } catch (let error as NSError) {
                    completion(photos: nil, error: error)
                    return
                }
                
                
                var photoArray = [Photo]()
                
                //handle loop JSON to custon object
                if let dataDictionary = jsonObject as? [[String:AnyObject]]{
                    for photoDict in dataDictionary {
                        // setting variables to empty string just incase json values returns nil
                        var name = "No Name"
                        var description = ""
                        var imgUrlString = ""
                        var photo: UIImage?
                        let defaultImage = UIImage(named: "noImage")!
                        
                        
                        //check json values
                        if let dictName = photoDict["imageName"] as? String {
                            name = dictName
                        }
                        if let dicDescription = photoDict["imageDescription"] as? String {
                            description = dicDescription
                        }
                        
                        if let dicImgUrlString = photoDict["imageURL"] as? String {
                            imgUrlString = dicImgUrlString
                        }
                        
//                        if let dictUrlString = photoDict["imageURL"] as? String {
//                            
//                            guard let url = NSURL(string: dictUrlString) else {return}
//
//                            if let data = NSData(contentsOfURL: url){
//                                if let image = UIImage(data: data){
//                                    //dispatch_async(dispatch_get_main_queue()) { () -> Void in
//                                        photo = image
//                                    //}
//                                }
//                            }
//                        }
                        
                        //create photo object to add to photo object array declared above
                        if let photo = photo {
                            //let newPhoto = Photo(name: name, description: description,  image: photo)
                            let newPhoto = Photo(name: name, description: description, imgUrlString: imgUrlString, image: defaultImage)
                            photoArray.append(newPhoto)
                        } else {
                            //let newPhoto = Photo(name: name, description: description, image: defaultImage)
                            let newPhoto = Photo(name: name, description: description, imgUrlString: imgUrlString, image: defaultImage)
                            photoArray.append(newPhoto)
                            print("photo is nil")
                        }
                    }
                    completion(photos: photoArray, error: nil)
                } else {
                    print("error looping through JSON object")
                    completion(photos: nil, error: nil)
                }
            }.resume()
        }
    }//fetchPhotos
    
    
    static func photosFromUrl(urlStringArray: [String], completion:(images: [UIImage])->Void){
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

