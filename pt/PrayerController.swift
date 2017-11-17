//
//  PrayerController.swift
//  pt
//
//  Created by Ilias Basha on 11/16/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import Foundation

class PrayerController {
    
    static let sharedInstance = PrayerController()
    var baseURL: String = "http://muslimsalat.com/"
    var prayers: [Prayer] = []
    var prayerDicts: [[String:String]] = []
    var prayerDictionary = [String:String]()
    


    func fetch(location: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)\(location).json") else { return }
        let parameters = ["key":Keys.apiKey]
        
        NetworkController.performRequest(for: url, httpMethod: .get, urlParameters: parameters, body: nil) { (data, error) in
            if let error = error {
                completion(false)
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                completion(false)
                return
            }
            
            guard let jsonData = (try? JSONSerialization.jsonObject(with: data,options: .allowFragments)) as? [String:Any] else {
                completion(false)
                print("Error serializing json")
                return
            }
            
            guard let itemsDict = jsonData["items"] as? [[String:String]] else {
                completion(false)
                print("Error parsing json")
                return
            }
            
            for items in itemsDict {
                for key in items.keys {
                    if key != "shurooq" && key != "date_for" {
                        self.prayerDictionary[key] = items[key]
                        if let timing = items[key] {
                            let prayer = Prayer(name: key, time: timing)
                            self.prayers.append(prayer)
                        }
                    }
                }
            }
            completion(true)
        }
    }
}
