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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableViewOutlet.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Photos"
        
        JsonController.fetchPhotoObjects { (photos, error) in
            if let photos = photos {
                
                PhotoController.sharedController.allPhotos = photos
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.tableViewOutlet.reloadData()
                }
                
                
            // OLD METHOD, leave it here just in case
                
//                let imgUrlArray = photos.map({$0.imgUrlString})
//                PhotoController.sharedController.photosFromUrl(imgUrlArray, completion: { (images) in
//                    for i in 0...images.count - 1 {
//                        if imgUrlArray[i] == PhotoController.sharedController.allPhotos[i].imgUrlString {
//                            PhotoController.sharedController.allPhotos[i].setImage(images[i])
//                        }
//                    }
//                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
//                        self.tableViewOutlet.reloadData()
//                    }
//                })
            }
        }
    }
    
    
    // MARK: - TableView DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //check if Json call loaded anything
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
            cell.roundImage()
            
            //pull photo from url and set it to UI and object
            PhotoController.sharedController.getPhoto(photo, completion: { (image) in
                cell.imageOutlet.image = image
                PhotoController.sharedController.allPhotos[indexPath.row].setImage(image)
            })
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier(myCell, forIndexPath: indexPath) as! PhotoTableViewCell
            
            //set default values for no data
            cell.imageOutlet.image = UIImage(named: "noImage")!
            cell.nameOutlet.text = "No Images"
            cell.nameOutlet.textColor = .myButtonColor()
            cell.descriptionOutlet.text = "There was a problem loading the images"
            cell.descriptionOutlet.textColor = .myButtonColor()
            cell.roundImage()
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
            //if no data, shouldnt be clickable
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