//
//  Prayer.swift
//  pt
//
//  Created by Ilias Basha on 11/16/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Prayer {
    let name: String
    let time: String

}

class Prayers: NSObject {
    var prayers: [Prayer] = []
    static var baseURL: String = "https://muslimsalat.com/"
    
    static func fetch(location: String) {
        guard let url = URL(string: "\(baseURL)\(location).json") else { return }
        let parameters = ["key":Keys.apiKey]
    
        print(url)
        NetworkController.performRequest(for: url, httpMethod: .get, urlParameters: parameters, body: nil) { (data, error) in
            if let error = error {
                print("Error fetching data: \(error)")
            }
            
            guard let data = data else {
                return
            }
            
            guard let jsonData = (try? JSONSerialization.jsonObject(with: data,
                                                                    options: .allowFragments)) as? [String:Any] else {
                return
            }
            
            guard let itemsDict = jsonData["items"] as? [String:Any] else {
                return
            }
            
            print(itemsDict)
        }
    }
}
