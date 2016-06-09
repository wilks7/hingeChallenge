//
//  AppearenceController.swift
//  hingeChallenge
//
//  Created by wilksmac on 6/9/16.
//  Copyright © 2016 wilksmac. All rights reserved.
//

import Foundation
import UIKit


extension UIColor{
    class func myColor() -> UIColor {
        return UIColor(red:0.15, green:0.68, blue:0.83, alpha:1.00)
    }
    
    class func myButtonColor() -> UIColor {
        return UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.00)
    }
    
}

class AppearenceController {
    
    
    class func setupAppearence(){
        
        UINavigationBar.appearance().tintColor = .myColor()
        //UINavigationBar.appearance().barTintColor = .myColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.myColor()]
        
        UIButton.appearance().tintColor = UIColor.myButtonColor()
        
        UITableView.appearance().backgroundColor = .myColor()
        
        UITableViewCell.appearance().backgroundColor = .myColor()
        
        
    }
    
}