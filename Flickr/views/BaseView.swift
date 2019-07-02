//
//  BaseView.swift
//  Flickr
//
//  Created by Sierra on 6/30/19.
//  Copyright © 2019 Nagiz. All rights reserved.
//

import UIKit

/// force view to emplement onDataRecieved to capture the returned data from viewModel
protocol BaseView {
    func onDataRecieved(data: AnyObject)
}
