//
//  RequestManager.swift
//  Alumni
//
//  Created by alumnos on 31/1/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import Foundation


let urlServer = "http://h2744356.stratoserver.net/alumni/AlumniFinal/public/index.php"


func requestUrlBuilder(ctrl: String, endpoint: String) -> String{
    let reqUrl = "\(urlServer)/\(ctrl)/\(endpoint)"
    return reqUrl
}
