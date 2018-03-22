//
//  ViewController.swift
//  Alumni
//
//  Created by alumnos on 10/1/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import Alamofire
import UIKit
import TextFieldEffects

class ViewController: UIViewController {
    
    
    var dataReceived:String?
   
    
   // let url_register = "http://h2744356.stratoserver.net/alumni/AlumniFinal/public/index.php/users/create.json"
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var txfName: HoshiTextField!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var txfEmail: UITextField!
    @IBOutlet weak var labelPass: UILabel!
    @IBOutlet weak var txfPass: UITextField!
    @IBOutlet weak var labelRepeatPass: UILabel!
    @IBOutlet weak var txfRepeatPass: UITextField!
    @IBOutlet weak var labelRegister: UILabel!
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Localize.setCurrentLanguage("es")
        
        labelName.text = "username".localized()
        labelEmail.text = "email".localized()
        labelPass.text = "password".localized()
        labelRepeatPass.text = "repeatpassword".localized()
        labelRegister.text = "labelReg".localized()
        btnRegister.setTitle("register".localized(), for: .normal)
        btnCancel.setTitle("imuser".localized(), for: .normal)
    }

    override func viewWillAppear(_ animated: Bool) {
        btnRegister.layer.cornerRadius = 10
        btnRegister.layer.masksToBounds = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goToLogin(_ sender: Any) {
        // Validar campos correctos y enviar a Login
        if txfName.text == "" || txfEmail.text == "" || txfPass.text == "" || txfRepeatPass.text == ""  {
            print("Debes rellenar todos los campos")
            showSimpleAlert(title: "Atención", message: "Rellena todos los campos")
        }
        if !isValidEmail(YourEMailAddress: txfEmail.text!) {
            print("NO ES VALIDO")
            showSimpleAlert(title: "Atención", message: "Formato de email no válido")
        }
        if (txfPass.text?.characters.count)! < 5 {
            print("La contraseña debe tener al menos cinco caracteres")
            showSimpleAlert(title: "Atención", message: "La contraseña debe tener al menos cinco caracteres")
        }
        if txfPass.text != txfRepeatPass.text {
            print("Las contraseñas no son iguales")
            showSimpleAlert(title: "Atención", message: "Las contraseñas no son iguales")
        }
        else {
            // Creamos los parámetros
            let parameters: Parameters = [
                "username":txfName.text!,
                "email":txfEmail.text!,
                "password":txfPass.text!
            ]
            
            let url = requestUrlBuilder(ctrl: "users", endpoint: "create.json")
            
            Alamofire.request(url, method: .post, parameters: parameters).responseJSON
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
                                
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                                vc.dataReceived = self.txfName!.text
                                self.present(vc, animated: true, completion: nil)
                                break
                            case 400:
                                print("es un 400")
                                self.showSimpleAlert(title: "Atención", message: "Email no existe o ya está registrado")
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
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
