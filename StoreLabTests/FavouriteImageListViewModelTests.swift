//
//  FavouriteImageListViewModelTests.swift
//  StoreLabTests
//
//  Created by Shahzaib I. Bhatti on 09/07/2023.
//

import XCTest
@testable import StoreLab

final class FavouriteImageListViewModelTests: XCTestCase {
    
    var viewModel: FavouriteImageListViewModel!
    var mockLikedImageManager: MockLikedImageManager!
    
    override func setUp() {
        super.setUp()
        
        mockLikedImageManager = MockLikedImageManager()
        mockLikedImageManager.mockedLikedImages = []
        viewModel = FavouriteImageListViewModel(likedImageManager: mockLikedImageManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockLikedImageManager = nil
        super.tearDown()
    }
    
    func testFavImagesWithZeroCount() async throws {
        XCTAssertNotNil(viewModel.images)
        XCTAssertEqual(viewModel.images.count, 0)
        viewModel.fetchData()
        XCTAssertNotNil(viewModel.images)
        XCTAssertEqual(viewModel.images.count, 0)
    }
    
    
    func testFavImagesWithCount() async throws {
        XCTAssertNotNil(viewModel.images)
        XCTAssertEqual(viewModel.images.count, 0)
        
        let mockLikedImageManager = MockLikedImageManager()
        mockLikedImageManager.mockedLikedImages = [ImageModel(id: "101", author: "", width: 400, height: 300, url: "", download_url: ""), ImageModel(id: "101", author: "", width: 400, height: 300, url: "", download_url: "")]
        
        let viewModel = FavouriteImageListViewModel(likedImageManager: mockLikedImageManager)
        
        viewModel.fetchData()
        
        let expectation = XCTestExpectation(description: "Fetch data with count 2")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
           
            XCTAssertNotNil(viewModel.images)
            XCTAssertEqual(viewModel.images.count, 2)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFavImagesToggleImage() async throws {
        XCTAssertNotNil(viewModel.images)
        XCTAssertEqual(viewModel.images.count, 0)
        
        let mockLikedImageManager = MockLikedImageManager()
        mockLikedImageManager.mockedLikedImages = [ImageModel(id: "101", author: "", width: 400, height: 300, url: "", download_url: ""), ImageModel(id: "101", author: "", width: 400, height: 300, url: "", download_url: "")]
        
        let viewModel = FavouriteImageListViewModel(likedImageManager: mockLikedImageManager)
        
        viewModel.fetchData()
        
        let expectation = XCTestExpectation(description: "Fetch data toggle images")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
           
            XCTAssertNotNil(viewModel.images)
            XCTAssertEqual(viewModel.images.count, 2)
            
            let imageCellViewModel = viewModel.getImageCellViewModel(image: viewModel.images.first!)
            
            XCTAssertFalse(imageCellViewModel.isLiked)
            imageCellViewModel.toggleLike()
            XCTAssertTrue(imageCellViewModel.isLiked)
            imageCellViewModel.toggleLike()
            XCTAssertFalse(imageCellViewModel.isLiked)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

}
