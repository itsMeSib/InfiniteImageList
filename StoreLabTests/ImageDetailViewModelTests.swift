//
//  ImageDetailViewModelTests.swift
//  StoreLabTests
//
//  Created by Shahzaib I. Bhatti on 09/07/2023.
//

import XCTest
@testable import StoreLab

final class ImageDetailViewModelTests: XCTestCase {
    
    var viewModel: ImageDetailViewModel!
    var mockLikedImageManager: MockLikedImageManager!
    
    override func setUp() {
        super.setUp()
        mockLikedImageManager = MockLikedImageManager()
        let image = ImageModel(id: "101", author: "test", width: 300, height: 300, url: "url", download_url: "download_url")
        
        viewModel = ImageDetailViewModel(image: image,
                                         likedImageManager: mockLikedImageManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockLikedImageManager = nil
        super.tearDown()
    }
    
    func testToggleImage() async throws {
        XCTAssertFalse(viewModel.isLiked)
        viewModel.toggleLike()
        XCTAssertTrue(viewModel.isLiked)
        viewModel.toggleLike()
        XCTAssertFalse(viewModel.isLiked)
    }
    
    func testUrlOfImage() async throws {
        let image = ImageModel(id: "101", author: "test", width: 300, height: 300, url: "url", download_url: "https://google.com")
        viewModel = ImageDetailViewModel(image: image, likedImageManager: mockLikedImageManager)
        XCTAssertNotNil(viewModel.url)
        XCTAssertEqual(viewModel.url, URL(string: "https://google.com"))
    }

}
