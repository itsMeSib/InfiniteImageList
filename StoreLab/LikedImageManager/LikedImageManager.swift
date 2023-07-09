//
//  LikedImageManager.swift
//  StoreLab
//
//  Created by Shahzaib I. Bhatti on 06/07/2023.
//

import Foundation

protocol LikedImageManaging {
    func toggleLikedImage(_ image: ImageModel)
    func getLikedImages() -> [ImageModel]
    func isImageLiked(id: String) -> Bool
}

class LikedImageManager: LikedImageManaging {
    
    private let userDefaults: UserDefaults
    private let likedImagesKey = "LikedImages"
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func toggleLikedImage(_ image: ImageModel) {
        var likedImages = getLikedImages()
        if let index = likedImages.firstIndex(where: { $0.id == image.id }) {
            likedImages.remove(at: index)
        } else {
            likedImages.append(image)
        }
        saveLikedImages(likedImages)
    }
    
    func getLikedImages() -> [ImageModel] {
        guard let likedImagesData = userDefaults.data(forKey: likedImagesKey) else {
            return []
        }
        
        let decoder = JSONDecoder()
        if let likedImages = try? decoder.decode([ImageModel].self, from: likedImagesData) {
            return likedImages
        }
        
        return []
    }
    
    private func saveLikedImages(_ images: [ImageModel]) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(images) {
            userDefaults.set(encodedData, forKey: likedImagesKey)
        }
    }
    
    func isImageLiked(id: String) -> Bool {
        let images = getLikedImages()
        guard !images.isEmpty else { return false }
        return !(images.filter({ $0.id == id }).isEmpty)
    }
}
