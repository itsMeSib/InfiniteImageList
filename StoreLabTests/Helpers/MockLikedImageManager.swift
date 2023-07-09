//
//  MockLikedImageManager.swift
//  StoreLabTests
//
//  Created by Shahzaib I. Bhatti on 08/07/2023.
//

import XCTest
@testable import StoreLab

class MockLikedImageManager: LikedImageManaging {
    
    var mockedLikedImages: [ImageModel] = []
    
    func toggleLikedImage(_ image: ImageModel) {
        // Implement any desired behavior or assertions for testing
        var likedImages = getLikedImages()
        if let index = likedImages.firstIndex(where: { $0.id == image.id }) {
            likedImages.remove(at: index)
        } else {
            likedImages.append(image)
        }
        saveMockedImages(images: likedImages)
    }
    
    private func saveMockedImages(images: [ImageModel]) {
        mockedLikedImages = images
    }
    
    func getLikedImages() -> [ImageModel] {
        return mockedLikedImages
    }
    
    func isImageLiked(id: String) -> Bool {
        return mockedLikedImages.contains(where: { $0.id == id })
    }
}
