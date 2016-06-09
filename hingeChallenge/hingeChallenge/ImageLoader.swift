//
//  ImageLoader.swift
//  hingeChallenge
//
//  Created by wilksmac on 6/9/16.
//  Copyright © 2016 wilksmac. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    
    var cache = NSCache()
    
    static let sharedLoader = ImageLoader()
    
    func imageForUrl(urlString: String, completionHandler:(image: UIImage?, url: String) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
            var data: NSData? = self.cache.objectForKey(urlString) as? NSData
            
            if let goodData = data {
                let image = UIImage(data: goodData)
                dispatch_async(dispatch_get_main_queue(), {() in
                    completionHandler(image: image, url: urlString)
                })
            }
            
            let url = NSURL(string: urlString)!
            
            var dataTask = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                if let data = data {
                    let image = UIImage(data: data)
                    self.cache.setObject(data, forKey: urlString)
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        completionHandler(image: image, url: urlString)
                    }
                }
                
            }.resume()
        })
    }
}

/*
 
 To use:
 
 ImageLoader.sharedLoader.imageForUrl("http://upload.wikimedia.org/wikipedia/en/4/43/Apple_Swift_Logo.png", completionHandler:{(image: UIImage?, url: String) in
    self.myImage.image = image!
 })
 
 */