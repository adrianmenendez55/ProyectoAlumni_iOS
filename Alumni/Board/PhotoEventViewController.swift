//
//  PhotoEventViewController.swift
//  Alumni
//
//  Created by alumnos on 12/3/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit
import Alamofire

class PhotoEventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraPhoto: UIImageView!
    @IBOutlet weak var changePhotoButton: UIButton!
    @IBOutlet weak var changePhotoEnabledButton: UIButton!
    
    var dataReceived:String?
    var imagePath:UIImagePickerController?
    var imageEvent:UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        Localize.setCurrentLanguage("es")
        
        changePhotoEnabledButton.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        changePhotoEnabledButton.layer.cornerRadius = changePhotoEnabledButton.bounds.size.width/2
        changePhotoEnabledButton.layer.masksToBounds = true
        
        //cameraPhoto.image = getEventImage()
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        
        
        
        cameraPhoto.image = image.scaledWithMaxWidthOrHeightValue(value: 200.00)
        
        changePhotoEnabledButton.isHidden = false
        callImage()
        
        dismiss(animated: true, completion: nil)
        
    }
    
   
    
    
    @IBAction func openLibraryAction(_ sender: Any) {
        showSimpleAlert(title: "Foto de la Noticia", message: "Elige una opcion para cambiar la foto")
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
        
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("myEventjpg.jpg")
        fileManager.createFile(atPath: imagePath as String, contents: UIImageJPEGRepresentation(cameraPhoto.image!, 1.0))
        if fileManager.fileExists(atPath: imagePath) {
            print("IMAGE SAVED")
            saveDataInUserDefaults(value: "UDEventImage", key: imagePath)
        }
        
        uploadImage(UIButton())
    }
    
    
    func uploadImage(_ sender: Any) {
        print("----------------------------->   UPLOAD IMAGE <-------------------")
        let fileManager = FileManager.default
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths)
        
        print("------------------------------>")
        print("token: \(getDataInUserDefaults(key: "UDToken")! as! String)")
        print(self.imageEvent)
        print("<-----------------------------")
        
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("myEventjpg.jpg")
        
        if fileManager.fileExists(atPath: imagePath){
            self.imageEvent = UIImage(contentsOfFile: imagePath)
            print("EL ARCHIVO EXISTE")
        }else{
            print("EL ARCHIVO NO EXISTE")
        }
        
        print("imagePath\(imagePath)")
        
        let url = URL(string:"http://h2744356.stratoserver.net/alumni/AlumniFinal/public/index.php/board/create.json")
        
        let parameters: Parameters = [
            "image_board": self.imageEvent
        ]
        
        let headers: HTTPHeaders = [
        "Authorization": getDataInUserDefaults(key: "UDToken")! as! String
        ]
        
        
        Alamofire.upload(
            
            multipartFormData: { multipartFormData in
                
                let dataImage = UIImageJPEGRepresentation(self.cameraPhoto.image!, 0.1)
                
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
    
    
    
    @IBAction func createEvent(_ sender: Any) {

        
        (parent as! PageViewController).goToNextPage(animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        (parent as! PageViewController).goToPreviousPage(animated: true)
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

