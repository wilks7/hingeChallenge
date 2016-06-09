//
//  ViewController.swift
//  hingeChallenge
//
//  Created by wilksmac on 6/8/16.
//  Copyright © 2016 wilksmac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let myCell = "myCell"
    
    var loadedImages = false
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //testing json
//        JsonController.fetchPhotos { (photos, error) in
//            if let photos = photos {
//                PhotoController.sharedController.allPhotos = photos
//                //self.tableViewOutlet.reloadData()
//            } else if let error = error {
//                print(error.localizedDescription)
//            }
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.tableViewOutlet.reloadData()
//            })
//        }
        
        JsonController.fetchPhotoObjects { (photos, error) in
            if let photos = photos {
                
                PhotoController.sharedController.allPhotos = photos
                let imgUrlArray = photos.map({$0.imgUrlString})
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.tableViewOutlet.reloadData()
                }
                JsonController.photosFromUrl(imgUrlArray, completion: { (images) in
                    for i in 0...images.count - 1 {
                        if imgUrlArray[i] == PhotoController.sharedController.allPhotos[i].imgUrlString {
                            PhotoController.sharedController.allPhotos[i].setImage(images[i])
                        }
                    }
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        self.tableViewOutlet.reloadData()
                    }
                })
            }
        }
        
    }
    
    
    // MAKR: - TableView DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if PhotoController.sharedController.allPhotos.count > 0 {
            return PhotoController.sharedController.allPhotos.count
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if PhotoController.sharedController.allPhotos.count > 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier(myCell, forIndexPath: indexPath) as! PhotoTableViewCell
            
            let photo = PhotoController.sharedController.allPhotos[indexPath.row]
            
            cell.setupCell(photo)
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier(myCell, forIndexPath: indexPath) as! PhotoTableViewCell
            
            cell.imageOutlet.image = UIImage(named: "noImage")!
            
            cell.nameOutlet.text = "No Images"
            
            cell.descriptionOutlet.text = "There was a problem loading the images"
            
            cell.selectionStyle = .None
            
            return cell
        }
        
        
    }
    
    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toGallery" {
            
            if PhotoController.sharedController.allPhotos.count != 0 {
            
                if let detailViewController = segue.destinationViewController as? GalleryViewController {
                
                //forces view from storyboard to load UI
                    _ = detailViewController.view
                
                    let indexPath = self.tableViewOutlet.indexPathForSelectedRow
                
                    if let selectedRow = indexPath?.row {
                        let photo = PhotoController.sharedController.allPhotos[selectedRow]
                    
                        detailViewController.updateView(photo, place: selectedRow, total: PhotoController.sharedController.allPhotos.count)
                    }
                }
            }
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "toGallery" {
            if PhotoController.sharedController.allPhotos.count == 0 {
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }
}