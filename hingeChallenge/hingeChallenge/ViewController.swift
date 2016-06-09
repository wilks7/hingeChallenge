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
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //testing json
        JsonController.fetchPhotos { (photos, error) in
            if let photos = photos {
                PhotoController.sharedController.allPhotos = photos
                self.tableViewOutlet.reloadData()
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableViewOutlet.reloadData()
            })
        }
        
    }
    
    
    // MAKR: - TableView DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PhotoController.sharedController.allPhotos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(myCell, forIndexPath: indexPath) as! PhotoTableViewCell
        
        let photo = PhotoController.sharedController.allPhotos[indexPath.row]
        
        cell.setupCell(photo)
        
        return cell
    }
    
    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toGallery" {
            
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