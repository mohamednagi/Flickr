//
//  ViewController.swift
//  Flickr
//
//  Created by Sierra on 6/30/19.
//  Copyright © 2019 Nagiz. All rights reserved.
//

import UIKit
import Kingfisher

class ListsView: UIViewController, BaseView {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imagesList: UITableView!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    var viewModel: ImagesViewModel!
    var container = [GenericModel]()
    lazy var rowsToDisplay = container
    
    
    /// init the viewModel at the beginning and specifing the default selected segment index with adding it's target
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ImagesViewModel(view: self)
        viewModel.getData(isGroup: false, isBegin: true, searchTerm: "")
        
        segmentedController.selectedSegmentIndex = 0
        segmentedController.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        imagesList.reloadData()
    }
    
    /// handling returned data from viewModel and filling the container with reloading the list with updated rows
    ///
    /// - Parameter data: returned data from viewModel
    func onDataRecieved(data: AnyObject) {
        guard let returnedData = data as? [GenericModel] else {return}
        container.removeAll()
        container = returnedData
        rowsToDisplay = container
        imagesList.reloadData()
    }
    
    /// handling the change in the selected segment index to reload the list with new rows
    @objc func handleSegmentChange() {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            if searchBar.text == "" {
                viewModel.getData(isGroup: false, isBegin: true, searchTerm: "")
            }else {
                viewModel.getData(isGroup: false, isBegin: false, searchTerm: searchBar.text ?? "")
            }
        default:
            viewModel.getData(isGroup: true, isBegin: false, searchTerm: searchBar.text ?? "")
        }
        rowsToDisplay = container
        imagesList.reloadData()
    }
}


