//
//  VCThree.swift
//  Alumni
//
//  Created by alumnos on 5/2/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit
import Alamofire
import AwesomeTextFieldSwift

class VCThree: UIViewController {
    
    @IBOutlet weak var newEventLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var introduceEventLbl: UILabel!
    @IBOutlet weak var indtroduceLocalizationTxt: AwesomeTextField!
    @IBOutlet weak var introduceURLTxt: AwesomeTextField!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    var dataReceived:String?
    var descriptionReceived:String?
    var pickerReceived:String?
    var indexReceived:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        backBtn.layer.cornerRadius = 10
        backBtn.layer.masksToBounds = true
        
        createBtn.layer.cornerRadius = 10
        createBtn.layer.masksToBounds = true
    }

    @IBAction func enterAction(_ sender: Any) {
    
            
            
            
            eventObject["localization"] = indtroduceLocalizationTxt.text!
            print("La localización del evento es \(indtroduceLocalizationTxt.text!)")
            
        eventObject["link"] = introduceURLTxt.text!
        print("El link del evento es \(introduceURLTxt.text!)")
        
        (parent as! PageViewController).goToNextPage(animated: true)
    }

    

    @IBAction func backButton(_ sender: Any) {
        (parent as! PageViewController).goToPreviousPage(animated: true)
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func showSimpleAlert(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction!) in
            print("Has presionado OK")
        })
        ac.addAction(okAction)
        self.present(ac, animated: true, completion: nil)
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
