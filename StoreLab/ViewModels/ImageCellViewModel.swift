//
//  ImageCellViewModel.swift
//  StoreLab
//
//  Created by Shahzaib I. Bhatti on 08/07/2023.
//

import Foundation

class ImageCellViewModel: ObservableObject {
    @Published var image: ImageModel
    @Published var isLiked = false
    
    private let likedImageManager: LikedImageManaging
    
    var url: URL {
        URL(string: self.image.download_url)!
    }
    
    init(image: ImageModel,
         likedImageManager: LikedImageManaging = LikedImageManager()) {
        self.image = image
        self.likedImageManager = likedImageManager
    }
    
    func toggleLike() {
        likedImageManager.toggleLikedImage(image)
        isImageLiked()
    }
    
    func isImageLiked() {
        isLiked = likedImageManager.isImageLiked(id: image.id)
    }
}
