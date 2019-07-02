//
//  ListsExtension.swift
//  Flickr
//
//  Created by Sierra on 7/2/19.
//  Copyright © 2019 Nagiz. All rights reserved.
//

import UIKit

extension ListsView: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    /// returning number of filtered rows
    ///
    /// - Parameters:
    ///   - tableView: the list of rows to display
    ///   - section: current section by default = 0
    /// - Returns: the return number of rows to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsToDisplay.count
    }
    
    /// filling the returned cell with captured data
    ///
    /// - Parameters:
    ///   - tableView: the shown list
    ///   - indexPath: current indexPath of the cell
    /// - Returns: returning the updated cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageCell
        cell.cellTitle.text = rowsToDisplay[indexPath.row].title
        let url = URL(string: (rowsToDisplay[indexPath.row].image))
        cell.cellImage?.kf.indicatorType = .activity
        cell.cellImage?.kf.setImage(with: url)
        return cell
    }
    
    /// search delegate method ,, for recent and specified images
    ///
    /// - Parameter searchBar: the provided search bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        rowsToDisplay.removeAll()
        switch segmentedController.selectedSegmentIndex {
        case 0:
            viewModel.getData(isGroup: false, isBegin: false, searchTerm: searchBar.text!)
            DispatchQueue.main.async {
                self.imagesList.reloadData()
            }
        default:
            viewModel.getData(isGroup: true, isBegin: false, searchTerm: searchBar.text!)
            DispatchQueue.main.async {
                self.imagesList.reloadData()
            }
        }
    }
    
    /// check when text change in search bar
    ///
    /// - Parameters:
    ///   - searchBar: the provided search bar
    ///   - searchText: user's search word
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            switch segmentedController.selectedSegmentIndex {
            case 0:
                viewModel.getData(isGroup: false, isBegin: true, searchTerm: "")
                DispatchQueue.main.async {
                    self.imagesList.reloadData()
                }
            default:
                viewModel.getData(isGroup: true, isBegin: false, searchTerm: "")
                DispatchQueue.main.async {
                    self.imagesList.reloadData()
                }
            }
        }
    }
}
