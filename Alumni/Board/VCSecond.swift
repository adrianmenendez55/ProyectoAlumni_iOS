//
//  VCSecond.swift
//  Alumni
//
//  Created by alumnos on 5/2/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit
import TextFieldEffects
import AwesomeTextFieldSwift

class VCSecond: UIViewController {
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var introduceTitleTxt: UITextField!
    @IBOutlet weak var descriptionTxt: AwesomeTextField!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleTwoLbl: UILabel!
    @IBOutlet weak var titleOneLbl: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var indexReceived:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("DID LOAD")
        print("MI TIPO DE EVENTO ES \(eventObject["id_type"])")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        backBtn.layer.cornerRadius = 10
        backBtn.layer.masksToBounds = true
        
        continueBtn.layer.cornerRadius = 10
        continueBtn.layer.masksToBounds = true
        
        let myBorderColor : UIColor = UIColor.white
        descriptionTextView.layer.borderColor = myBorderColor.cgColor
        descriptionTextView.layer.borderWidth = 2.5
        descriptionTextView.layer.cornerRadius = 10
        
        print("WILL APPEAR")
        print("MI TIPO DE EVENTO ES \(eventObject["id_type"])")
    }
    
    
    
    @IBAction func enterAction(_ sender: Any) {
        if introduceTitleTxt.text == "" && descriptionTextView.text ==
            "" {
            showSimpleAlert(title: "Atención", message: "Los campos están vacíos")
            
        }
        if introduceTitleTxt.text == "" || descriptionTextView.text ==
            "" {
            if introduceTitleTxt.text == "" {
                showSimpleAlert(title: "Atención", message: "El título del anuncio está vacío")
            }
            if descriptionTextView.text == "" {
                showSimpleAlert(title: "Atención", message: "La descripción del anuncio está vacía")
            }
        }else{
            
            
            
                eventObject["title"] = introduceTitleTxt.text!
                print("El título del evento es \(introduceTitleTxt.text!)")
            
                eventObject["description"] = descriptionTextView.text!
                print("La descripción del evento es \(descriptionTextView.text!)")
            /* Lo del picker */
           
                print("ES DEFAULT")
            

        (parent as! PageViewController).goToNextPage(animated: true)
        }
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

}
