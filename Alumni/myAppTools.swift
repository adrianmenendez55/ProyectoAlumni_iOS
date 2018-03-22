//
//  myAppTools.swift
//  Alumni
//
//  Created by alumnos on 10/1/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import Foundation
import UIKit

let defaults = UserDefaults.standard

extension UIImage {
    func scaledWithMaxWidthOrHeightValue(value: CGFloat) -> UIImage? {
        
        let width = self.size.width
        let height = self.size.height
        
        let ratio = width/height
        
        var newWidth = value
        var newHeight = value
        
        if ratio > 1 {
            newWidth = width * (newHeight/height)
        } else {
            newHeight = height * (newWidth/width)
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: newHeight), false, 0)
        
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

func isValidEmail(YourEMailAddress: String) -> Bool {
    let REGEX: String
    REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourEMailAddress)
}

func saveDataInUserDefaults(value: String, key: String){
    var user = [String: Any]()
    if defaults.object(forKey: "user") != nil {
        user = defaults.object(forKey: "user") as! [String : Any]
    }
    user.updateValue(value, forKey: key)
    defaults.set(user, forKey: "user")
    defaults.synchronize
    print("USER IN USERDEFAULTS :::: \(String(describing: defaults.object(forKey: "user")))")
}


func getDataInUserDefaults(key: String) -> Any? {
    var user = [String: Any]()
      print(defaults.object(forKey: "user"))
    var data = ""
    if defaults.object(forKey: "user") != nil {
        user = defaults.object(forKey: "user") as! [String : Any]
      
        data = user[key] as! String
    }
    //print("DATA IN USERDEFAULTS :::: \(String(describing: data))")
    return data
    
    
}
func getDataLoginUserDefaults() -> Bool{
   defaults.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")

    var isLogin: Bool = false
    if getDataInUserDefaults(key: "UDToken") != nil  && getDataInUserDefaults(key: "UDToken") as! String != "" {
        isLogin = true
    }
    return isLogin
}

func logOut(mvc: UIViewController){
    defaults.set(nil, forKey: "user")
    defaults.synchronize()
    let vc = mvc.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    mvc.present(vc, animated: true, completion: nil)
}

func getProfileImage() -> UIImage{
    var myProfileImage = UIImage()
    let fileManager = FileManager.default
    let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("myjpg.jpg")
    if fileManager.fileExists(atPath: imagePath) {
        myProfileImage = UIImage(contentsOfFile: imagePath)!
    } else {
        myProfileImage = UIImage(named: "user (3)")!
    }
    
    return myProfileImage
}

func getEventImage() -> UIImage{
    var myEventImage = UIImage()
    let fileManager = FileManager.default
    let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("myEventjpg.jpg")
    if fileManager.fileExists(atPath: imagePath) {
        myEventImage = UIImage(contentsOfFile: imagePath)!
    } else {
        myEventImage = UIImage(named: "eventCev")!
    }
    return myEventImage
}

//MARK: - EVENT BUILDER

var eventObject:[String:Any] = [:]
var groupsObject = [[String]]()

