//
//  ImagesViewModel.swift
//  Flickr
//
//  Created by Sierra on 6/30/19.
//  Copyright © 2019 Nagiz. All rights reserved.
//

import UIKit

class ImagesViewModel: BaseViewModel {
    
    var listsRepository = ListsRepository()
    
    /// fetching data from repository and passing it to onDataRecieved
    ///
    /// - Parameters:
    ///   - isGroup: check filter if groups or photos
    ///   - isBegin: check if no words written yet in search bar
    ///   - searchTerm: the search keyword user entered
    func getData(isGroup: Bool, isBegin: Bool, searchTerm: String){
        listsRepository.getLists(isGroup: isGroup, isBegin: isBegin, searchTerm: searchTerm) { (returnedObject) in
            // implement Data logic  -->sort
            DispatchQueue.main.async {
               self.view.onDataRecieved(data: returnedObject as AnyObject)
            }
        }
    }
}
