//
//  RecoverPassViewController.swift
//  Alumni
//
//  Created by alumnos on 10/1/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit
import Alamofire

class RecoverPassViewController: UIViewController {
    
    let url_recover = "http://h2744356.stratoserver.net/alumni/AlumniFinal/public/index.php/users/emailValidate.json"
    
    @IBOutlet weak var labelRecoverPass: UILabel!
    
    @IBOutlet weak var descriptionLblPassword: UITextView!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var txfEmail: UITextField!
    
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Localize.setCurrentLanguage("es")
        
        labelRecoverPass.text = "labRecover".localized()
        descriptionLblPassword.text = "descriptionLblPassword".localized()
        labelEmail.text = "email".localized()
        btnSend.setTitle("send".localized(), for: .normal)
        btnCancel.setTitle("cancel".localized(), for: .normal)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        btnSend.layer.cornerRadius = 10
        btnSend.layer.masksToBounds = true
        
        btnCancel.layer.cornerRadius = 10
        btnCancel.layer.masksToBounds = true
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
    
    @IBAction func sendPass(_ sender: Any) {
        
        
        if txfEmail.text == ""  {
            showSimpleAlert(title: "Atención", message: "Campo vacío")
        }else if !isValidEmail(YourEMailAddress: txfEmail.text!) {
            print("NO ES VALIDO")
            showSimpleAlert(title: "Atención", message: "Email incorrecto")
        } else {
            
            let parameters: Parameters = [
                "email":txfEmail.text!
            ]
            
            Alamofire.request(url_recover, method: .post, parameters: parameters).responseJSON {
                response in
                print(response)
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
                                let data = json["data"] as! Dictionary<String, Any>
                                let token = data["token"] as! String
                                print("MI TOKEN ES :::: \(token)")
                                saveDataInUserDefaults(value: token, key: "UDToken")
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "IntroduceNewPasswordViewController") as! IntroduceNewPasswordViewController
                                self.present(vc, animated: true, completion: nil)
                                
                                
                                break
                            case 400:
                                self.showSimpleAlert(title: "Email", message: "Email no registrado")
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
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
