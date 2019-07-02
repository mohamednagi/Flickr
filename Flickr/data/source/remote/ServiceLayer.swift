//
//  ServiceLayer.swift
//  Flickr
//
//  Created by Sierra on 6/30/19.
//  Copyright © 2019 Nagiz. All rights reserved.
//

import UIKit

let apiKey = "52752cdfbd499575a5ce6126404d32be"

extension Int {
    func square() -> Int {
        return self * self
    }
}

class ServiceLayer: NSObject {
    
    /// opens session with APIs to fetch data from depending on some parameters we sent to it
    ///
    /// - Parameters:
    ///   - isGroup: if user in search filter
    ///   - isBegin: if there's no search words yet
    ///   - searchTerm: the search keyword user entered
    ///   - completion: caputing returned data from API
    func getData(isGroup: Bool, isBegin: Bool, searchTerm: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var endPoint = ""
        if isBegin == true {
            endPoint = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(apiKey)&format=json&nojsoncallback=1"
        }else {
            switch isGroup {
            case true:
                endPoint = "https://api.flickr.com/services/rest/?method=flickr.groups.search&api_key=\(apiKey)&text=\(searchTerm)&per_page=40&format=json&nojsoncallback=1"
            default:
                endPoint = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(searchTerm)&per_page=40&format=json&nojsoncallback=1"
            }
        }
        guard let dataUrl = URL(string: endPoint) else {return}
        URLSession.shared.dataTask(with: dataUrl, completionHandler: completion).resume()
    }
}
