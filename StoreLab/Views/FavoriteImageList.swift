//
//  FavoriteImageList.swift
//  StoreLab
//
//  Created by Shahzaib I. Bhatti on 08/07/2023.
//

import SwiftUI

struct FavoriteImageList: View {
    @StateObject var viewModel: FavouriteImageListViewModel
    
    var body: some View {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                    ForEach(viewModel.images) { image in
                        NavigationLink(destination: ImageDetailPage(viewModel: ImageDetailViewModel(image: image))) {
                            ImageCell(viewModel: viewModel.getImageCellViewModel(image: image))
                        }
                    }
                }
                .padding()
                .onAppear {
                    viewModel.fetchData()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Favorite Image List")
    }
}
