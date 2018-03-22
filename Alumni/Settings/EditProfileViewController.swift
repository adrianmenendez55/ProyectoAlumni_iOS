//
//  EditProfileViewController.swift
//  Alumni
//
//  Created by alumnos on 6/3/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit
import Alamofire

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var nameProfileLbl: UILabel!
    @IBOutlet weak var nameProfileTextLbl: UILabel!
    @IBOutlet weak var changePhotoButton: UIButton!
    @IBOutlet weak var changePhotoEnabledButton: UIButton!
    @IBOutlet weak var emailProfileLbl: UILabel!
    @IBOutlet weak var emailProfileTextLbl: UILabel!
    @IBOutlet weak var descriptionProfileLbl: UILabel!
    @IBOutlet weak var descriptionProfileTextLbl: UITextView!
    @IBOutlet weak var cameraPhoto: UIImageView!
    
    var dataReceived:String?
    var imagePath:UIImagePickerController?
    var imageProfile:UIImage?
    
   // var userReceived:Dictionary<String, Any> = [:]
   // var getUserDict:Dictionary<String, Any> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        Localize.setCurrentLanguage("es")
        
       
        changePhotoEnabledButton.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        

        
        changePhotoEnabledButton.layer.cornerRadius = changePhotoEnabledButton.bounds.size.width/2
        changePhotoEnabledButton.layer.masksToBounds = true
        
        
        cameraPhoto.layer.cornerRadius = cameraPhoto.bounds.size.width/2
        cameraPhoto.layer.masksToBounds = true
        
        let myBorderColor : UIColor = UIColor(red: 0/255, green: 136/255, blue: 149/255, alpha: 1.0)
        
        descriptionProfileTextLbl.layer.borderColor = myBorderColor.cgColor
        descriptionProfileTextLbl.layer.borderWidth = 1.5
        descriptionProfileTextLbl.layer.cornerRadius = 10
        
        cameraPhoto.image = getProfileImage()
        
//        nameProfileTextLbl.text = getUserDict["username"] as? String
//        emailProfileTextLbl.text = getUserDict["email"] as? String
//        descriptionProfileTextLbl.text = getUserDict["description"] as? String
//
//        print(getUserDict)
    }
    

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        cameraPhoto.image = image.scaledWithMaxWidthOrHeightValue(value: 200.00)
        cameraPhoto.layer.cornerRadius = cameraPhoto.bounds.size.width/2
        cameraPhoto.layer.masksToBounds = true
        changePhotoEnabledButton.isHidden = false
        callImage()
        
        dismiss(animated: true, completion: nil)
        
    }

    
    @IBAction func openLibraryAction(_ sender: Any) {
        showSimpleAlert(title: "Foto de Perfil", message: "Elige una opcion para cambiar la foto")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func showSimpleAlert(title: String, message: String){
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cameraAction = UIAlertAction(title: "Camara", style: .default, handler: {(action:UIAlertAction!) in
            
            print("Has presionado Camara")
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                var imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                
                imagePicker.sourceType = .camera
                
                imagePicker.allowsEditing = false
                
                self.present(imagePicker, animated: true, completion: nil)
                
                
                
                
            }else {
                
                print("NO HAY CAMARA DISPONIBLE")
            }
        })
        
        
        
        
        let libraryAction = UIAlertAction(title: "Galeria", style: .default, handler: {(action:UIAlertAction!) in
            
            print("Has presionado Galeria")
            
            if  UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
                
            {
                
                var imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                
                imagePicker.sourceType = .photoLibrary
                
                imagePicker.allowsEditing = false
                
                self.present(imagePicker, animated: true, completion: nil)
                
                
            }
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: {(action:UIAlertAction!) in
            print("Has presionado Cancelar")
        })
        
        ac.addAction(cameraAction)
        ac.addAction(libraryAction)
        ac.addAction(cancelAction)
        
        self.present(ac, animated: true, completion: nil)
        
    }
    
    
    
    func callImage(){
        
        
        let fileManager = FileManager.default
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths)
        
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("myjpg.jpg")
        fileManager.createFile(atPath: imagePath as String, contents: UIImageJPEGRepresentation(cameraPhoto.image!, 1.0))
        if fileManager.fileExists(atPath: imagePath) {
            saveDataInUserDefaults(value: "UDUserImage", key: imagePath)
        }
        
        uploadImage(UIButton())
    }
    
    
    func uploadImage(_ sender: Any) {
        
        let fileManager = FileManager.default
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths)
        
        
        print("------------------------------>")
        print("token: \(getDataInUserDefaults(key: "UDToken")! as! String)")
        print(self.imageProfile)
        print("<-----------------------------")
        
        
        
     
        
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("myjpg.jpg")
        
        if fileManager.fileExists(atPath: imagePath){
            self.imageProfile = UIImage(contentsOfFile: imagePath)
            print("EL ARCHIVO EXISTE")
        }else{
            print("EL ARCHIVO NO EXISTE")
        }
        
        print("imagePath\(imagePath)")
        
        let url = URL(string:"http://h2744356.stratoserver.net/alumni/AlumniFinal/public/index.php/users/upload.json")
        
        let parameters: Parameters = [
            "image_profile": self.imageProfile
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": getDataInUserDefaults(key: "UDToken")! as! String
        ]
        
        Alamofire.upload(
            
            multipartFormData: { multipartFormData in
                
                let dataImage = UIImageJPEGRepresentation( self.imageProfile!, 0.1)
                
                if self.cameraPhoto != nil
                {
                    multipartFormData.append(dataImage!, withName: "image", fileName: "photo.jpeg", mimeType: "image/jpeg")
                }
                
        },
            
            to: url!,
            headers: headers,
            encodingCompletion: { encodingResult in
                
                switch encodingResult {
                    
                case .success:
                    
                    print("La peticion ha funcionado")
                    
                    //let alert = self.showSimpleAlert(title: "Foto cambiada".localized(), message:"")
                    
                case .failure:
                    print("La peticion no ha funcionado")
                    
                }
        })
    }
    

    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}


//    // MARK:- Alerts tools
//    func showSimpleAlert(title: String, message: String){
//        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction!) in
//            print("Has presionado OK")
//        })
//
//        ac.addAction(okAction)
//        self.present(ac, animated: true, completion: nil)
//        }
//    }
