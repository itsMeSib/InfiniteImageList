//
//  LikedImageManagerTests.swift
//  StoreLabTests
//
//  Created by Shahzaib I. Bhatti on 09/07/2023.
//

import XCTest
@testable import StoreLab

class LikedImageManagerTests: XCTestCase {
    
    var manager: LikedImageManager!
    var mockUserDefaults: MockUserDefaults!
    
    override func setUp() {
        super.setUp()
        mockUserDefaults = MockUserDefaults()
        manager = LikedImageManager(userDefaults: mockUserDefaults)
    }
    
    override func tearDown() {
        manager = nil
        mockUserDefaults = nil
        super.tearDown()
    }
    
    class MockUserDefaults: UserDefaults {
        var savedData: Data?
        
        override func set(_ value: Any?, forKey defaultName: String) {
            if let data = value as? Data {
                savedData = data
            }
        }
        
        override func data(forKey defaultName: String) -> Data? {
            return savedData
        }
    }
    
    func testToggleLikedImage() {
        let image1 = ImageModel(id: "1", author: "author 1", width: 0, height: 0, url: "image1.jpg", download_url: "image1.jpg")
        let image2 = ImageModel(id: "2", author: "author 2", width: 0, height: 0, url: "image2.jpg", download_url: "image2.jpg")
        
        manager.toggleLikedImage(image1)
        
        XCTAssertTrue(manager.isImageLiked(id: image1.id))
        
        XCTAssertFalse(manager.isImageLiked(id: image2.id))
        
        manager.toggleLikedImage(image2)
        
        XCTAssertTrue(manager.isImageLiked(id: image2.id))
    }
    
    func testGetLikedImages() {
        let image1 = ImageModel(id: "1", author: "author 1", width: 0, height: 0, url: "image1.jpg", download_url: "image1.jpg")
        let image2 = ImageModel(id: "2", author: "author 2", width: 0, height: 0, url: "image2.jpg", download_url: "image2.jpg")
        
        let encodedImages = try! JSONEncoder().encode([image1, image2])
        mockUserDefaults.savedData = encodedImages
        
        let likedImages = manager.getLikedImages()
        
        XCTAssertEqual(likedImages.count, 2)
        XCTAssertTrue(likedImages.contains { $0.id == image1.id })
        XCTAssertTrue(likedImages.contains { $0.id == image2.id })
    }
    
    func testIsImageLiked() {
        let image1 = ImageModel(id: "1", author: "author 1", width: 0, height: 0, url: "image1.jpg", download_url: "image1.jpg")
        
        let encodedImages = try! JSONEncoder().encode([image1])
        mockUserDefaults.savedData = encodedImages
        
        XCTAssertTrue(manager.isImageLiked(id: image1.id))
        
        XCTAssertFalse(manager.isImageLiked(id: "2"))
    }
    
    func testGetLikedImagesWithZero() {
        let likedImages = manager.getLikedImages()
        XCTAssertNotNil(likedImages)
        XCTAssertEqual(likedImages.count, 0)
    }
    
}
