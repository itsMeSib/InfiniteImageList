//
//  ImageListViewModel.swift
//  StoreLab
//
//  Created by Shahzaib I. Bhatti on 06/07/2023.
//

import SwiftUI

class ImageListViewModel: ObservableObject {
    @Published private(set) var images: [ImageModel] = []
    private let networkManager: NetworkManaging
    private let likedImageManager: LikedImageManaging
    private var page = 1
    private var isFetchingData = false
    private let pageSize = 30
    
    init(networkManager: NetworkManaging = NetworkManager(),
         likedImageManager: LikedImageManaging = LikedImageManager()) {
        self.networkManager = networkManager
        self.likedImageManager = likedImageManager
    }
    
    func fetchData() async  throws {
        guard !isFetchingData else { return }
        
        isFetchingData = true
        
        do {
            let fetchedImages: [ImageModel] = try await networkManager.fetch(endpoint: Endpoint(.list, ["page": "\(page)", "limit": "\(pageSize)"]))
            
            DispatchQueue.main.async {
                self.images.append(contentsOf: fetchedImages)
                self.isFetchingData = false
            }
            
            page += 1
        } catch {
            DispatchQueue.main.async {
                self.isFetchingData = false
            }
            
            if let networkError = error as? NetworkError {
                print("Network Error: ", networkError.localizedDescription)
                // Present a user-friendly error message or handle the error appropriately.
            } else {
                print("Error: ", error.localizedDescription)
                // Present a user-friendly error message or handle the error appropriately.
            }
            
            throw error
        }
    }
    
    func shouldFetchNextPage(_ image: ImageModel) -> Bool {
        guard let lastImage = images.last else { return false }
        return image.id == lastImage.id
    }
    
    func getImageCellViewModel(image: ImageModel) -> ImageCellViewModel {
        return ImageCellViewModel(image: image)
    }
}
