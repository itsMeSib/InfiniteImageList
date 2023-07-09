//
//  FavouriteImageListViewModel.swift
//  StoreLab
//
//  Created by Shahzaib I. Bhatti on 08/07/2023.
//

import Foundation

class FavouriteImageListViewModel: ObservableObject {
    @Published private(set) var images: [ImageModel] = []
    private let likedImageManager: LikedImageManaging
    
    init(likedImageManager: LikedImageManaging = LikedImageManager()) {
        self.likedImageManager = likedImageManager
    }
    
    func fetchData() {
        images = likedImageManager.getLikedImages()
    }
    
    func getImageCellViewModel(image: ImageModel) -> ImageCellViewModel {
        return ImageCellViewModel(image: image)
    }
}
