//
//  PanelViewController.swift
//  Alumni
//
//  Created by alumnos on 29/1/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import QuartzCore

class PanelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var userAvatarImage: UIImageView!
    

    var arrEventData:[Any] = [Any]()
    var filteredArray = [String]()
    var arrTempData:[Any] = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    func getAllEventsRequest(){
        arrTempData.removeAll()
        arrEventData.removeAll()
        let url = requestUrlBuilder(ctrl: "board", endpoint: "boards.json")
        print("mi URL __ \(url)")
        let token = getDataInUserDefaults(key:"UDToken")
        print("token __ \(token)")
        let headers: HTTPHeaders = [
            "Authorization": token! as! String,
            "Accept": "application/json"
        ]
        
        Alamofire.request(url, method: .get, headers: headers).responseJSON{response in
            print("REQUEST ::: \(response.request)")
            print("RESULT ::: \(response.result)")
            print("VALUE ::: \(response.value)")
            
            switch response.result {
            case .success:
                if response.value != nil {
                    let a = response.value as! Dictionary<String, Any>
                    self.arrEventData = a["data"] as! Array<Any>
                    print(self.arrEventData)
                    self.arrEventData = self.arrEventData.reversed()
                    self.arrTempData = self.arrEventData
                    // print("MYARRAY _____ \(self.arrEventData)")
                    self.tableView.reloadData()
                }

            case .failure:
                print("error \(response.error)")
                print("failure")
            }
        }
        
    }
    
    
    
    func createEventRequest(title:String, description:String, localization:Float, group:[Int], link:String?, idUser:Int, idType:Int,  controller:UIViewController, lat:Float?, lon:Float?, image:Data?){
        
        let url = requestUrlBuilder(ctrl: "board", endpoint: "boards.json")
        
       
        var parameters: Parameters = ["title": title, "description": description, "id_type":idType, "image_board":image]
        
        
        
        if lat != nil && lon != nil{
            parameters["lat"] = lat
            parameters["lon"] = lon
        }
        
        if link != nil{
            parameters["link"] = link
        }
        
        let token = getDataInUserDefaults(key:"UDToken")
        print("token __ \(token)")
        
        let headers: HTTPHeaders = [
            "Authorization": token! as! String,
            "Accept": "application/json"
        ]
        //print("parameters ___ \(parameters)")
       // print("headers ______ \(headers)")
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: headers).responseJSON{response in
//print("REQUEST ::: \(response.request)")
            //print("RESULT ::: \(response.result)")
            //print("VALUE ::: \(response.value)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        userAvatarImage.image = getProfileImage()
        userAvatarImage.layer.cornerRadius = userAvatarImage.layer.frame.width/2
        userAvatarImage.clipsToBounds  = true
        
          getAllEventsRequest()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        let cellDict = arrTempData[indexPath.row] as! Dictionary<String, Any>
        cell.eventLbl.text = cellDict["title"] as? String
        cell.informationEventLbl.text = cellDict["description"] as? String
        
        
        
        if cellDict["id_type"] as! String == "1" {

            cell.cellView.backgroundColor = UIColor(red: 188/255, green: 40/255, blue: 32/255, alpha: 1.0)
            cell.iconImage.image = #imageLiteral(resourceName: "events_icon")
            cell.titleEvent.text = "Eventos"

        }
        if cellDict["id_type"] as! String == "2" {

            cell.cellView.backgroundColor = UIColor(red: 21/255, green: 116/255, blue: 158/255, alpha: 1.0)
            cell.iconImage.image = #imageLiteral(resourceName: "notice_ic")
            cell.titleEvent.text = "Noticias"
            
        }
        if cellDict["id_type"] as! String == "3" {

            cell.cellView.backgroundColor = UIColor(red: 27/255, green: 155/255, blue: 78/255, alpha: 1.0)
            cell.iconImage.image = #imageLiteral(resourceName: "ic_jobs")
            cell.titleEvent.text = "Ofertas de trabajo"
        }
        if cellDict["id_type"] as! String == "4" {

            cell.cellView.backgroundColor = UIColor(red: 221/255, green: 192/255, blue: 16/255, alpha: 1.0)
            cell.iconImage.image = #imageLiteral(resourceName: "notification_ic")
            cell.titleEvent.text = "Notificaciones"
        }
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection sections: Int) -> Int{
            return arrTempData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("________ \(arrTempData[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailEventViewController") as! DetailEventViewController
        vc.eventReceived = arrTempData[indexPath.row] as! Dictionary<String, Any>
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func createEvent(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        self.present(vc, animated: true, completion: nil)
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
    
    
    @IBAction func typeSearchBegin(_ sender: UITextField) {
         print(sender.text!)
        if sender.text!.count >= 3 {
            arrTempData.removeAll()
            print("EMPIEZA LA BUSQUEDA")
            print(sender.text!)
            for (index, item) in arrEventData.enumerated() {
                let i = item as! Dictionary<String, Any>
                let d = (i["description"] as! String).lowercased()
                let t = (i["title"] as! String).lowercased()
                print(d)
                if d.contains((sender.text as! String).lowercased()) || t.contains((sender.text as! String).lowercased()) {
                    print("DESCRIPTION COINCIDE ------->\(i["description"])")
                    arrTempData.append(item)
                }
            }
            redrawTableView()
        } else {
            arrTempData = arrEventData
            redrawTableView()
        }
        
        print(arrTempData)
       
    }
    
    func redrawTableView(){
        tableView.reloadData()
        

        //tableView.sizeToFit()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

