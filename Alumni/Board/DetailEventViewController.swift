//
//  DetailEventViewController.swift
//  Alumni
//
//  Created by alumnos on 19/2/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit

class DetailEventViewController: UIViewController {
    
    @IBOutlet weak var titleEventLbl: UILabel!
    @IBOutlet weak var imageEventView: UIImageView!
    @IBOutlet weak var descriptionEventTxt: UITextView!
    @IBOutlet weak var ic_localitation: UIButton!
    @IBOutlet weak var ic_link: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var typeInfo: UILabel!
    
    var arrEventData:[Any] = [Any]()
    var eventReceived:Dictionary<String, Any> = [:]
    
    var lat : Float?
    var lon : Float?
    
    var idReceived = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        imageEventView.image = getEventImage()        
        backButton.layer.cornerRadius = 10
        backButton.layer.masksToBounds = true
        
        ic_localitation.layer.cornerRadius = ic_localitation.bounds.size.width/2
        ic_localitation.layer.masksToBounds = true
        
        ic_link.layer.cornerRadius = ic_link.bounds.size.width/2
        ic_link.layer.masksToBounds = true
        
        titleEventLbl.text = eventReceived["title"] as! String
        descriptionEventTxt.text = eventReceived["description"] as! String
        typeInfo.text = eventReceived["id_type"] as! String
        
        if eventReceived["id_type"] as! String == "1"{
            typeInfo.text = "Eventos"
        }
        if eventReceived["id_type"] as! String == "2"{
            typeInfo.text = "Noticias"
        }
        if eventReceived["id_type"] as! String == "3"{
            typeInfo.text = "Ofertas de trabajo"
        }
        if eventReceived["id_type"] as! String == "4"{
            typeInfo.text = "Notificaciones"
        }
        
        print(eventReceived)
        
        
//        if(eventReceived["lat"] as? String) != nil && (eventReceived["lon"] as? String) != nil){
//
//            self.lat = Float(self.eventReceived["lat"] as! String)
//            self.lon = Float(self.eventReceived["lon"] as! String)
//
//            addressFromPosition(lat: lat!, lon: lon!, controller: self)
//
//            self.ic_localitation.isHidden = false
//        }else{
//            self.ic_localitation.isHidden = true
//
//        }
//
//        if [eventReceived]["url"] as? String == nil{
//            ic_link.isHidden = true
//
//        }else{
//            ic_link.isHidden = false
//        }
    }
    
    
    
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   

    @IBAction func localizationAction(_ sender: Any) {
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocalizationViewController") as! LocalizationViewController
//        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func linkAction(_ sender: Any) {
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
