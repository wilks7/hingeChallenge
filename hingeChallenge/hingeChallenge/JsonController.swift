//
//  JsonController.swift
//  hingeChallenge
//
//  Created by wilksmac on 6/8/16.
//  Copyright © 2016 wilksmac. All rights reserved.
//

import Foundation

class JsonController {
    
    
    static let urlString = "https://hinge-homework.s3.amazonaws.com/client/services/homework.json"
    
    static func fetchPhotos(completion:(photos: [Photo]?, error: NSError?)->Void){
        
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
                
                //handle loop JSON to custon object
                var photoArray = [Photo]()
                
                if let dataDictionary = jsonObject as? [[String:AnyObject]]{
                    for photoDict in dataDictionary {
                        // setting variables to empty string just incase if let returns nil
                        var name = ""
                        var description = ""
                        
                        if let dictName = photoDict["imageName"] as? String {
                            name = dictName
                        }
                        if let dicDescription = photoDict["imageDescription"] as? String {
                            description = dicDescription
                        }
                        
                        let newPhoto = Photo(name: name, description: description)
                        photoArray.append(newPhoto)
                    }
                    completion(photos: photoArray, error: nil)
                } else {
                    print("error looping through JSON object")
                    completion(photos: nil, error: nil)
                }

                
            }//dataTask
            dataTask.resume()
        }
    }//fetchPhotos
    
    
}