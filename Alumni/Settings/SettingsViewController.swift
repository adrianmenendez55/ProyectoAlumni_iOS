//
//  SettingsViewController.swift
//  Alumni
//
//  Created by alumnos on 20/2/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {



    
    
    @IBOutlet weak var ConfigurationLbl: UILabel!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var EditProfileLbl: UILabel!
    @IBOutlet weak var help: UIButton!

    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var SettingsLbl: UILabel!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var LogoutLbl: UILabel!

    @IBOutlet weak var QuestionsFrecuentsTextView: UITextView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        ConfigurationLbl.text = "ConfigurationLbl".localized()
        EditProfileLbl.text = "EditProfileLbl".localized()
        QuestionsFrecuentsTextView.text = "QuestionsFrecuentsTextView".localized()
        SettingsLbl.text = "SettingsLbl".localized()
        LogoutLbl.text = "LogoutLbl".localized()
        
        // Do any additional setup after loading the view.
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        editProfile.layer.cornerRadius = 10
        editProfile.layer.masksToBounds = true
        
        help.layer.cornerRadius = 10
        help.layer.masksToBounds = true
        
        settings.layer.cornerRadius = 10
        settings.layer.masksToBounds = true
        
        logout.layer.cornerRadius = 10
        logout.layer.masksToBounds = true
    }

    
    @IBAction func EditProfile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func AnswerQuestions(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AnswerQuestionsViewController") as! AnswerQuestionsViewController
        self.present(vc, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        logOut(mvc: self)
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
