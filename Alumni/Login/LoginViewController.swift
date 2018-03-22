//
//  LoginViewController.swift
//  Alumni
//
//  Created by alumnos on 10/1/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    
    let defaultValues = UserDefaults.standard
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var txfName: UITextField!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var txfPassword: UITextField!
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var btnEnter: UIButton!
    @IBOutlet weak var btnGoToRegister: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var img_Logo: UIImageView!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        Localize.setCurrentLanguage("es")
        
        labelName.text = "username".localized()
        labelPassword.text = "password".localized()
        btnEnter.setTitle("enter".localized(), for: .normal)
        labelText.text = "haveaccount".localized()
        btnGoToRegister.setTitle("reg".localized(), for: .normal)
        btnForgotPassword.setTitle("forgot".localized(), for: .normal)
        // Do any additional setup after loading the view.
        
        // Si el usuario está logueado
        if defaultValues.string(forKey: "username") != nil {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
            self.present(vc, animated: true, completion: nil)
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        if getDataLoginUserDefaults() {
            print("Logueado")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            self.present(vc, animated: true, completion: nil)
        } else {
            print("No logueado")
            //let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            //self.present(vc, animated: true, completion: nil)
        }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        btnEnter.layer.cornerRadius = 10
        btnEnter.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func enterAction(_ sender: Any) {
        if txfName.text == "" && txfPassword.text ==
            "" {
            showSimpleAlert(title: "Atención", message: "Los campos están vacíos")
            
        }
        if txfName.text == "" || txfPassword.text ==
            "" {
            if txfName.text == "" {
                showSimpleAlert(title: "Atención", message: "El nombre de usuario está vacío")
            }
            if txfPassword.text == "" {
                showSimpleAlert(title: "Atención", message: "La contraseña está vacía")
            }
            
        } else {
                print("INS")
                let parameters: Parameters = [
                    "username":txfName.text!,
                    "password":txfPassword.text!
                ]
            
            
        let url = requestUrlBuilder(ctrl: "users", endpoint: "login.json")
            Alamofire.request(url, method: .get, parameters: parameters).responseJSON
                {
                    response in
                    print("Request :: \(String(describing: response.request))")
                    print("Response :: \(String(describing: response.response))")
                    print("Result :: \(response.result)")
                    print("Err ::: \(String(describing: response.error))")
                    
                    switch response.result {
                        case .success:
                            let json = response.result.value as! Dictionary<String, Any>
                            print("JSON :: \(json)")
                            
                               // let code = json["code"] as? Int
                            if let code = json["code"] as? Int {
                                    print("code :: \(code)")
                                    switch code {
                                        case 200:
                                            let data = json["data"] as! Dictionary<String, Any>
                                            print("data :: \(data)")
                                            let token = data["token"] as! String
                                            print("token :: \(token)")
                                            //self.showSimpleAlert(title: "Login", message: "Login correcto")
                                            saveDataInUserDefaults(value: token, key: "UDToken")
                                            
                                            _ = getDataInUserDefaults(key: "UDToken") as! String
                                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                                                self.present(vc, animated: true, completion: nil)
                                            
                                        break
                                    case 400:
                                        self.showSimpleAlert(title: "Login", message: "Login incorrecto")
                                        print("es un 400")
                                        
                                            break
                                        default:
                                            break
                                    }
                                } else {
                                    print("CODE ES NULO")
                                }
                        case .failure:
                                print("Error :: \(response.error)")
                                print(response.response?.statusCode)
                                let statusCode = response.response?.statusCode
                                switch(statusCode as! Int) {
                                    case 400:
                                        self.showSimpleAlert(title: "Error 400", message: "Syntaxis Error")
                                        break
                                    case 401:
                                        self.showSimpleAlert(title: "Error 401", message: "You don't have authorization")
                                        break
                                    case 403:
                                        self.showSimpleAlert(title: "Error 403", message: "Access Forbidden")
                                        break
                                    case 405:
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
            
    


    
    @IBAction func goToRegister(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goToForgotPass(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecoverPassViewController") as! RecoverPassViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func textFieldShouldReturn(textField: UITextField){
        textField.resignFirstResponder();

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
   
    
    

//    func textFieldShouldReturn(textField: UITextField) -> Bool
//    {
//        textField.resignFirstResponder()
//        return true
//    }
    
   
    
    // MARK:- Alerts tools
    func showSimpleAlert(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction!) in
            print("Has presionado OK")
        })
        ac.addAction(okAction)
        self.present(ac, animated: true, completion: nil)
        
    }
}


