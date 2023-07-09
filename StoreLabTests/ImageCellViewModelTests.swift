//
//  ImageCellViewModelTests.swift
//  StoreLabTests
//
//  Created by Shahzaib I. Bhatti on 08/07/2023.
//
import XCTest
@testable import StoreLab

class ImageListViewModelTests: XCTestCase {
    
    var viewModel: ImageListViewModel!
    var mockNetworkManager: MockNetworkManager!
    var mockLikedImageManager: MockLikedImageManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        mockLikedImageManager = MockLikedImageManager()
        
        viewModel = ImageListViewModel(networkManager: mockNetworkManager,
                                       likedImageManager: mockLikedImageManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        mockLikedImageManager = nil
        super.tearDown()
    }
    
    func testFetchData() async throws {
        
        try await viewModel.fetchData()
        
        let expectation = XCTestExpectation(description: "Fetch data Functions are called")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockNetworkManager.fetchPostsCalled)
            
            XCTAssertEqual(self.viewModel.images.count, 3)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchImages() async throws {
        
        try await self.viewModel.fetchData()
        
        let expectation = XCTestExpectation(description: "Check Post Count")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockNetworkManager.fetchPostsCalled)
            
            XCTAssertEqual(self.viewModel.images.count, 3)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testImageCellViewModelSuccess() async throws {

        let image = ImageModel(id: "102", author: "", width: 0, height: 0, url: "", download_url: "")

        try await viewModel.fetchData()

        let expectation = XCTestExpectation(description: "Fetch Data and match Post Cell ViewModel")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {

            XCTAssertEqual(self.viewModel.images.count, 3)

            let imageCellViewModel = self.viewModel.getImageCellViewModel(image: self.viewModel.images.first!)

            XCTAssertEqual(imageCellViewModel.image.id, image.id)
            XCTAssertEqual(imageCellViewModel.isLiked, false)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchDataWithError() async throws {
        let mockNetworkManager = MockNetworkManager(error: NetworkError.invalidEndpoint)

        let viewModel = ImageListViewModel(networkManager: mockNetworkManager)

        do {
            try await viewModel.fetchData()
        } catch  let err {
            XCTAssertEqual(err.localizedDescription, NetworkError.invalidEndpoint.localizedDescription)
        }

        XCTAssertNotNil(viewModel.images)
        XCTAssertTrue(viewModel.images.isEmpty)
    }
    
    func testFetchDataWithRandomError() async throws {
        let mockNetworkManager = MockNetworkManager(error: NetworkError.invalidEndpoint)

        let viewModel = ImageListViewModel(networkManager: mockNetworkManager)

        do {
            try await viewModel.fetchData()
        } catch  let err {
            XCTAssertEqual(err.localizedDescription, NetworkError.invalidEndpoint.localizedDescription)
        }

        XCTAssertNotNil(viewModel.images)
        XCTAssertTrue(viewModel.images.isEmpty)
    }
    
    func testFetchDataWithErrorUnknown() async throws {
        let error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid Responce"])
        let mockNetworkManager = MockNetworkManager(error: error)

        let viewModel = ImageListViewModel(networkManager: mockNetworkManager)

        do {
            try await viewModel.fetchData()
        } catch  let err {
            XCTAssertNotNil(err)
        }

        XCTAssertNotNil(viewModel.images)
        XCTAssertTrue(viewModel.images.isEmpty)
    }
    
    func testToggleImage() async throws {
        
        try await viewModel.fetchData()
        
        let expectation = XCTestExpectation(description: "Fetch data and like and dislike image")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockNetworkManager.fetchPostsCalled)
            XCTAssertEqual(self.viewModel.images.count, 3)
            
            let imageCellViewModel = self.viewModel.getImageCellViewModel(image: self.viewModel.images.first!)
            
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
