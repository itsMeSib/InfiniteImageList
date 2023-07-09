//
//  MockData.swift
//  StoreLabTests
//
//  Created by Shahzaib I. Bhatti on 08/07/2023.
//

import XCTest

struct MockData {
    static let images = """
        [
        {"id":"102", "author":"Ben Moore", "width":4320, "height":3240, "url":"https://unsplash.com/photos/pJILiyPdrXI", "download_url":"https://picsum.photos/id/102/4320/3240"},
        {"id":"103", "author":"Ilham Rahmansyah", "width":2592, "height":1936, "url":"https://unsplash.com/photos/DwTZwZYi9Ww", "download_url":"https://picsum.photos/id/103/2592/1936"},
        {"id":"104", "author":"Dyaa Eldin", "width":3840,  "height":2160, "url":"https://unsplash.com/photos/2fl-ocJ5MOA",  "download_url":"https://picsum.photos/id/104/3840/2160"}
        ]
        """
    
    static let imagesFromPage2 = """
        [
        {"id":"106", "author":"Ben Moore 2", "width":4320, "height":3240, "url":"https://unsplash.com/photos/pJILiyPdrXI", "download_url":"https://picsum.photos/id/102/4320/3240"},
        {"id":"107", "author":"Ilham Rahmansyah 2", "width":2592, "height":1936, "url":"https://unsplash.com/photos/DwTZwZYi9Ww", "download_url":"https://picsum.photos/id/103/2592/1936"},
        {"id":"108", "author":"Dyaa Eldin 2", "width":3840,  "height":2160, "url":"https://unsplash.com/photos/2fl-ocJ5MOA",  "download_url":"https://picsum.photos/id/104/3840/2160"}
        ]
        """
}
