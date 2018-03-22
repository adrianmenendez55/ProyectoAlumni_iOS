//
//  IntroduceNewPasswordViewController.swift
//  Alumni
//
//  Created by alumnos on 25/1/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit
import AwesomeTextFieldSwift
import Alamofire

class IntroduceNewPasswordViewController: UIViewController {

    @IBOutlet weak var recoveryPassword2Lbl: UILabel!
    @IBOutlet weak var IntroduceNewPasswordTextView: UITextView!
    @IBOutlet weak var newPasswordLbl: UILabel!
    @IBOutlet weak var newPasswordTextField: AwesomeTextField!
    
    @IBOutlet weak var repeatNewPasswordLbl: UILabel!
    @IBOutlet weak var repeatNewPasswordTextField: AwesomeTextField!
    
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var backPasswordButton: UIButton!
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Localize.setCurrentLanguage("es")
        
        recoveryPassword2Lbl.text = "labRecover".localized()
        newPasswordLbl.text = "newPassword".localized()
        repeatNewPasswordLbl.text = "repeatNewPasswordLbl".localized()
        IntroduceNewPasswordTextView.text = "introduceNewPassword".localized()
        
        changePasswordButton.setTitle("changePasswordButton".localized(), for: .normal)
        backPasswordButton.setTitle("backPasswordButton".localized(), for: .normal)
       

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        backPasswordButton.layer.cornerRadius = 10
        backPasswordButton.layer.masksToBounds = true
        
        changePasswordButton.layer.cornerRadius = 10
        changePasswordButton.layer.masksToBounds = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changePassword(_ sender: Any) {
        
        if newPasswordTextField.text == "" && repeatNewPasswordTextField.text ==
            "" {
            showSimpleAlert(title: "Atención", message: "Los campos están vacíos")
            
        }
        if newPasswordTextField.text == "" || repeatNewPasswordTextField.text ==
            "" {
            if newPasswordTextField.text == "" {
                showSimpleAlert(title: "Atención", message: "El campo de nueva contraseña está vacío")
            }
            if repeatNewPasswordTextField.text == "" {
                showSimpleAlert(title: "Atención", message: "El campo de repetir contraseña está vacía")
            }
            
            if newPasswordTextField.text ==  repeatNewPasswordTextField.text  {
                print("Las contraseñas coinciden")
            } else{
                showSimpleAlert(title: "Atención", message: "Las contraseñas no coinciden")
            }
                
        } else {
            
            let parameters: Parameters = [
                "newpass":newPasswordTextField.text!,
                "repeatPass":repeatNewPasswordTextField.text!
            ]
            
            let headers: HTTPHeaders = [
                "Authorization": getDataInUserDefaults(key: "UDToken") as! String
            ]
            
            let url = requestUrlBuilder(ctrl: "users", endpoint: "changePass.json")
            
            Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON {
                response in

                print("Request :: \(String(describing: response.request))")
                print("Response :: \(String(describing: response.response))")
                print("Result :: \(response.result)")
                
                switch response.result {
                case .success:
                    let json = response.result.value as! Dictionary<String,Any>
                    print("JSON :: \(json)")
                    if let code = json["code"] as? Int{
                        switch code {
                        case 200:
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
                            self.present(vc, animated: true, completion: nil)
                            
                            break
                        case 400:
                            
                            self.showSimpleAlert(title: "Contraseña", message: "Las contraseñas no coinciden")
                            print("es un 400")
                            break
                        default:
                            break
                        }
                    }
                case .failure:
                    print("Error ::\(String(describing: response.error))")
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
    
        
    
    
    @IBAction func backRecoverPassword(_ sender: Any) {
       // dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
