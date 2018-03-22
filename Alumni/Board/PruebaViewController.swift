//
//  PruebaViewController.swift
//  Alumni
//
//  Created by alumnos on 6/2/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit

class PruebaViewController: UIViewController {

    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var NewsBtn: UIButton!
    @IBOutlet weak var ofertsBtn: UIButton!
    @IBOutlet weak var notificationsBtn: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
                eventBtn.layer.cornerRadius = 10
                eventBtn.layer.masksToBounds = true
        
                NewsBtn.layer.cornerRadius = 10
                NewsBtn.layer.masksToBounds = true
        
                ofertsBtn.layer.cornerRadius = 10
                ofertsBtn.layer.masksToBounds = true
        
                notificationsBtn.layer.cornerRadius = 10
                notificationsBtn.layer.masksToBounds = true
        
                cancelButton.layer.cornerRadius = 10
                cancelButton.layer.masksToBounds = true
    }
    @IBAction func eventCreate(_ sender: Any) {
        let itemSelected = sender as! UIButton
        switch itemSelected {
        case eventBtn:
            eventObject["id_type"] = 1
            print("Es tipo EVENTO")
        case NewsBtn:
            eventObject["id_type"] = 2
            print("Es tipo NOTICIA")
        case ofertsBtn:
            eventObject["id_type"] = 3
            print("Es tipo OFERTA")
        case notificationsBtn:
            eventObject["id_type"] = 4
            print("Es tipo NOTIFICACIÓN")
        default:
            print("ES DEFAULT")
        }
        (parent as! PageViewController).goToNextPage(animated: true)
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
