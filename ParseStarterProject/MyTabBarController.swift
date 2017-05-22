//
//  MyTabBarController.swift
//  ParseStarterProject-Swift
//
//  Created by Varun Babu on 22/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class MyTabBarController: RAMAnimatedTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //UITabBar.appearance().tintColor = UIColor.red
        //UITabBar.appearance().barTintColor = UIColor.black
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
//        let numberOfItems = CGFloat((tabBarController?.tabBar.items!.count)!)
//        
//        let tabBarItemSize = CGSize(width: (tabBarController?.tabBar.frame.width)! / numberOfItems,
//                                    height: (tabBarController?.tabBar.frame.height)!)
//        
//        tabBarController?.tabBar.selectionIndicatorImage
//            = UIImage.imageWithColor(color: UIColor.black,
//                                     size: tabBarItemSize).resizableImage(withCapInsets: .zero)
//        
//        tabBarController?.tabBar.frame.size.width = self.view.frame.width + 4
//        tabBarController?.tabBar.frame.origin.x = -2

    }
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//extension UIImage
//{
//    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage
//    {
//        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        color.setFill()
//        UIRectFill(rect)
//        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return image
//    }
//}

