//
//  FlickrTests.swift
//  FlickrTests
//
//  Created by Sierra on 6/30/19.
//  Copyright © 2019 Nagiz. All rights reserved.
//

import XCTest
@testable import Flickr

class FlickrTests: XCTestCase {
    
    /// testing if there was data or error in API's response
    func testAPI() {
         let endPoint = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(apiKey)&format=json&nojsoncallback=1"
        guard let dataUrl = URL(string: endPoint) else {return}
        URLSession.shared.dataTask(with: dataUrl) { (data, response, error) in
            
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            
            if error != nil {
                XCTFail()
            }
        }.resume()
    }
}
