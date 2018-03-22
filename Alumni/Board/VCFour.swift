//
//  VCFour.swift
//  Alumni
//
//  Created by alumnos on 12/2/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit
import Alamofire

class VCFour: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var Lbl0: UILabel!
    @IBOutlet weak var Lbl1: UILabel!
    @IBOutlet weak var Lbl2: UILabel!
    
    
    @IBOutlet weak var switch0: UISwitch!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    
    @IBOutlet weak var unSelect: UIButton!
    @IBOutlet weak var createEventBtn: UIButton!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Lbl0.layer.cornerRadius = 10
        Lbl0.layer.masksToBounds = true
        
        Lbl1.layer.cornerRadius = 10
        Lbl1.layer.masksToBounds = true
        
        Lbl2.layer.cornerRadius = 10
        Lbl2.layer.masksToBounds = true
        
        unSelect.layer.cornerRadius = 10
        unSelect.layer.masksToBounds = true
        
        createEventBtn.layer.cornerRadius = 10
        createEventBtn.layer.masksToBounds = true
    }

    @IBAction func switchAction0(_ sender: UISwitch) {
        switch0Off()
    }
    @IBAction func switchAction1(_ sender: UISwitch) {
        switch1Off()
    }
    @IBAction func switchAction2(_ sender: UISwitch) {
        switch2Off()
    }
    
    
    func switch0Off(){
        //switch0.isEnabled = false
        //TextField0.isEnabled = false
    }
    func switch1Off(){
        //switch1.isEnabled = false
        //TextField1.isEnabled = false
    }
    func switch2Off(){
        //switch2.isEnabled = false
        //TextField2.isEnabled = false
    }
    
    func goAwayKeyboard(){
        Lbl0.resignFirstResponder()
        Lbl1.resignFirstResponder()
        Lbl2.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        goAwayKeyboard()
    }
    
    @IBAction func unselectAction(_ sender: UIButton) {
        unselectAll()
    }
    
   


    @IBAction func createEvent(_ sender: UIButton) {
        
        
        
        
        
        
            if switch0.isOn == true {
                eventObject["group"] = 1
                print("Switch 0 guardado \(Lbl0.text!)")
            }else{
                print("No se ha guardado switch0")
            }

            if switch1.isOn == true {
                eventObject["group"] = 2
                print("Switch 1 guardado \(Lbl1.text!)")
            }else{
                print("No se ha guardado switch1")
            }

            if switch2.isOn == true {
                eventObject["group"] = 3
                print("Switch 2 guardado \(Lbl2.text!)")
            }else{
                print("No se ha guardado switch2")
            }
        

        
        if switch0.isOn == false && switch1.isOn == false && switch2.isOn == false
           {
            showSimpleAlert(title: "Atención", message: "Debes seleccionar al menos un grupo")
            
        }else{
                    let parameters: Parameters = [
                     "id_type":eventObject["id_type"]!,
                     "title":eventObject["title"]!,
                     "description":eventObject["description"]!,
                     "localization":eventObject["localization"]!,
                     "link":eventObject["link"]!,
                     "group":eventObject["group"]
                     ]
            
            let headers: HTTPHeaders = ["Authorization": getDataInUserDefaults(key: "UDToken") as! String]
            print("******** \(getDataInUserDefaults(key: "UDToken") as! String)")
            
                    let url = requestUrlBuilder(ctrl: "board", endpoint: "create.json")
            
                    Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON
                        {
                            response in
                            print("Request :: \(String(describing: response.request))")
                            print("Response :: \(String(describing: response.response))")
                            print("Result :: \(response.result)")
                            
                            switch response.result {
                            case .success:
                                let json = response.result.value as! Dictionary<String, Any>
                                print("JSON :: \(json)")
                                let code = json["code"] as! Int
                                print(response.response?.statusCode)
                                print(code)
                                if let code = json["code"] as? Int{
                                    switch code{
                                    case 200:
                                        let data = json["data"] as! Dictionary<String, Any>
                                        print("data :: \(data)")
//                                        let token = data["token"] as! String
//                                        print("token :: \(token)")
//                                        //self.showSimpleAlert(title: "Login", message: "Login correcto")
//                                        (value: token, key: "UDToken")

                                        _ = getDataInUserDefaults(key: "UDToken") as! String
                                        (self.parent as! PageViewController).goToNextPage(animated: true)
                                        print("Evento creado")
                                        break
                                    case 400:
                                        print("es un 400")
                                        self.showSimpleAlert(title: "Atención", message: "Fallo al crear evento")
                                        break
                                    case 500:
                                        print("es un 500")
                                        
                                        break
                                    default:
                                        break
                                    }
                                }
                            case .failure:
                                print("Error :: \(String(describing: response.error))")
                                if let httpStatusCode = response.response?.statusCode {
                                    switch(httpStatusCode) {
                                    case 400:
                                        self.showSimpleAlert(title: "Error 400", message: "Syntaxis Error")
                                        break
                                    case 401:
                                        self.showSimpleAlert(title: "Error 401", message: "You don't have authorization")
                                        break
                                    case 403:
                                        self.showSimpleAlert(title: "Error 403", message: "Access Forbidden")
                                        break
                                    case 404:
                                        self.showSimpleAlert(title: "Error 404", message: "URL Not Found")
                                        break
                                    case 500:
                                        self.showSimpleAlert(title: "Error 500", message: "Internal Server Error")
                                        break
                                    case 503:
                                        self.showSimpleAlert(title: "Error 503", message: "Service Unavailable")
                                        break
                                    default:
                                        break
                                    }
                                }
                            }
                    }
                }
            }

        

    
    func unselectAll(){
        switch0.isEnabled = true
        Lbl0.isEnabled = true
        
        switch1.isEnabled = true
        Lbl1.isEnabled = true
        
        switch2.isEnabled = true
        Lbl2.isEnabled = true
        
        switch0.setOn(false, animated: true)
        switch1.setOn(false, animated: true)
        switch2.setOn(false, animated: true)
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Alerts tools
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

