//
//  ImagesRepository.swift
//  Flickr
//
//  Created by Sierra on 6/30/19.
//  Copyright © 2019 Nagiz. All rights reserved.
//

import UIKit

class ListsRepository: NSObject {

    var remote = ServiceLayer()
    var dataArray = [GenericModel]()
    
    /// parsing returned data from API into json object
    ///
    /// - Parameters:
    ///   - isGroup: check filter if groups or photos
    ///   - isBegin: check if no words written yet in search bar
    ///   - searchTerm: the search keyword user entered
    ///   - completionHandler: capturing array of the general model to pass to the viewModel
    func getLists(isGroup: Bool, isBegin: Bool, searchTerm: String, completionHandler: @escaping (_ array:[GenericModel]) -> ()) {
        remote.getData(isGroup: isGroup, isBegin: isBegin, searchTerm: searchTerm) { (data, _, error) in
            guard let data = data, error == nil else {return}
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else {return}
                    if json["stat"] as? String == "fail" {
                        self.dataArray.removeAll()
                        completionHandler(self.dataArray)
                    }else {
                    switch isGroup {
                    case true:
                        guard let groupsList = json["groups"] as? [String:Any] else {return}
                        guard let groups = groupsList["group"] as? [[String:Any]] else {return}
                        self.dataArray.removeAll()
                        for group in groups {
                            guard let groupName = group["name"] as? String else {return}
                            let groupObject = GenericModel(title: groupName, image: "")
                            self.dataArray.append(groupObject)
                        }
                    case false:
                        guard let photosList = json["photos"] as? [String:Any] else {return}
                        guard let photos = photosList["photo"] as? [[String:Any]] else {return}
                        self.dataArray.removeAll()
                        for image in photos {
                            guard let title = image["title"] as? String else {return}
                            guard let imageID = image["id"] as? String else {return}
                            guard let farmID = image["farm"] as? Int else {return}
                            guard let serverID = image["server"] as? String else {return}
                            guard let secretID = image["secret"] as? String else {return}
                            let image = "https://farm\(farmID).staticflickr.com/\(serverID)/\(imageID)_\(secretID).jpg"
                            let imageObject = GenericModel(title: title, image: image)
                            self.dataArray.append(imageObject)
                        }
                    }
                    completionHandler(self.dataArray)
                    }
                }catch {
                    print(error.localizedDescription)
                }
        }
    }
}
