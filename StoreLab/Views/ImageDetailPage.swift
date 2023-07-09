//
//  ImageDetailPage.swift
//  StoreLab
//
//  Created by Shahzaib I. Bhatti on 06/07/2023.
//

import SwiftUI
import Kingfisher

struct ImageDetailPage: View {
    @ObservedObject var viewModel: ImageDetailViewModel
    
    var body: some View {
        VStack {
            KFImage(viewModel.url)
                .resizable()
                .placeholder {
                    Image(systemName: "photo")
                }
                .onProgress { receivedSize, totalSize in }
                .onSuccess { result in  }
                .onFailure { error in }
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: 300)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 4)
            
            Text(viewModel.image.author)
                .font(.title)
            
            Button(action: {
                viewModel.toggleLike()
            }) {
                Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                    .font(.title)
                    .foregroundColor(viewModel.isLiked ? .red : .primary)
            }
            .padding()
            .onAppear {
                viewModel.isImageLiked()
            }
            
            Spacer()
        }
        .padding()
    }
}
