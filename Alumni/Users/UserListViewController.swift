//
//  UserListViewController.swift
//  Alumni
//
//  Created by alumnos on 7/2/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usersLbl: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var arrUserData:[Any] = [Any]()
    var arrTempData:[Any] = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersLbl.text = "usersLbl".localized()
        
        // FAKE REQUEST - DELETEME
        
        //createEventRequest(title: "Titulo del Reques", description: "Descripcion del request", localization: 0.2, group: [1], link: "Mi link del evento", idUser: 2, idType: 4, controller: self, lat: 0.33, lon: 0.33, image: nil)
        getAllUserRequest()
    }
    
    
    
    // Do any additional setup after loading the view.
    
    
    func getAllUserRequest(){
        let url = requestUrlBuilder(ctrl: "users", endpoint: "users.json")
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
                print("success")
                self.arrUserData = response.value as! Array<Any>
                print("MYARRAY _____ \(self.arrUserData)")
                
                
                if(self.searchTextField.text == ""){
                    self.tableView.reloadData()
                }
                
            case .failure:
                print("error \(response.error)")
                print("failure")
            }
        }
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return arrUserData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomUserListTableViewCell
        let cellDict = arrUserData[indexPath.row] as! Dictionary<String, Any>
        
        print(cellDict)
        cell.nameUserLbl.text = cellDict["username"] as? String
        //cell.classUserLbl.text = cellDict["group"] as! String
        //cell.userImage.image = cellDict["image"] as! UIImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("________ \(arrUserData[indexPath.row])")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailUserViewController") as! DetailUserViewController
        vc.userReceived = arrUserData[indexPath.row] as! Dictionary<String, Any>
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func typeSearchBegin(_ sender: UITextField) {
        print(sender.text!)
        if sender.text!.count >= 3 {
            arrTempData.removeAll()
            print("EMPIEZA LA BUSQUEDA")
            for (index, item) in arrUserData.enumerated() {
                let i = item as! Dictionary<String, Any>
                let d = (i["username"] as! String).lowercased()
                let t = (i["email"] as! String).lowercased()
                print(d)
                print(sender.text!)
                if d.contains((sender.text as! String).lowercased()) || t.contains((sender.text as! String).lowercased()) {
                    print("DESCRIPTION COINCIDE ------->\(i["email"])")
                    arrTempData.append(item)
                }
            }
            print("------------")

            arrUserData = arrTempData
            redrawTableView()
            getAllUserRequest()
            
            
        } else {
            arrTempData = arrUserData
            redrawTableView()
        }
        
//        print(arrTempData)
        
    }
    
    func redrawTableView(){
        tableView.reloadData()
        
        
        //tableView.sizeToFit()
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
    
}

