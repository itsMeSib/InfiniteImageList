//
//  ImageDetailViewModel.swift
//  StoreLab
//
//  Created by Shahzaib I. Bhatti on 06/07/2023.
//

import SwiftUI

class ImageDetailViewModel: ObservableObject {
    @Published var image: ImageModel
    @Published var isLiked = false
    
    private let likedImageManager: LikedImageManaging
    
    var url: URL {
        URL(string: image.download_url)!
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
