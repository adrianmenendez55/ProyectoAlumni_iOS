//
//  VCFour.swift
//  Alumni
//
//  Created by alumnos on 5/2/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit

class VCFive: UIViewController {
    
    @IBOutlet weak var newEventLbl: UILabel!
    @IBOutlet weak var eventCreatedLbl: UILabel!
    @IBOutlet weak var goodLbl: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        acceptBtn.layer.cornerRadius = 10
        acceptBtn.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
