//
//  DetailUserViewController.swift
//  Alumni
//
//  Created by alumnos on 21/2/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit

class DetailUserViewController: UIViewController {
    
    
    @IBOutlet weak var imageDetailUser: UIImageView!
    @IBOutlet weak var nameDetailUser: UILabel!
    @IBOutlet weak var name2DetailUser: UILabel!
    @IBOutlet weak var emailDetailUser: UILabel!
    @IBOutlet weak var email2DetailUser: UILabel!
    @IBOutlet weak var descriptionDetailUser: UILabel!
    @IBOutlet weak var description2DetailUser: UITextView!
    
    
    var userReceived:Dictionary<String, Any> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        imageDetailUser.layer.cornerRadius = imageDetailUser.bounds.size.width/2
        imageDetailUser.layer.masksToBounds = true
        
        let myBorderColor : UIColor = UIColor(red: 0/255, green: 136/255, blue: 149/255, alpha: 1.0)
        
        description2DetailUser.layer.borderColor = myBorderColor.cgColor
        description2DetailUser.layer.borderWidth = 1.5
        description2DetailUser.layer.cornerRadius = 10
        
            
        name2DetailUser.text = userReceived["username"] as? String
            email2DetailUser.text = userReceived["email"] as! String
            description2DetailUser.text = userReceived["email"] as! String
        
            
            print(userReceived)
        
        
        
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
