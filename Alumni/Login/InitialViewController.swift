//
//  InitialViewController.swift
//  Alumni
//
//  Created by alumnos on 10/1/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    @IBOutlet weak var recoverPasswordLbl: UILabel!
    @IBOutlet weak var emailSendTxt: UITextView!
    @IBOutlet weak var acceptBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defaults.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        Localize.setCurrentLanguage("es")
        
        recoverPasswordLbl.text = "recuperarcontraseña".localized()
        emailSendTxt.text = "correoderestablecimiento".localized()
        acceptBtn.setTitle("aceptar".localized(), for: .normal)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func acceptButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(vc, animated: true, completion: nil)
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
