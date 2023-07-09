//
//  ImageCell.swift
//  StoreLab
//
//  Created by Shahzaib I. Bhatti on 06/07/2023.
//

import SwiftUI
import Kingfisher

struct ImageCell: View {
    
    @StateObject var viewModel: ImageCellViewModel
    @State private var isLoading = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            KFImage(viewModel.url)
                .resizable()
                .placeholder {
                    Image(systemName: "photo")
                }
                .onProgress { receivedSize, totalSize in
                    isLoading = true
                }
                .onSuccess { result in
                    isLoading = false
                }
                .onFailure { error in
                    isLoading = false
                }
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 4)
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            Button(action: {
                viewModel.toggleLike()
            }) {
                Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                    .foregroundColor(viewModel.isLiked ? .red : .primary)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
                    .offset(x: -8, y: -8)
                    .shadow(radius: 2)
            }
            .opacity(!isLoading ? 1 : 0)
            .onAppear {
                viewModel.isImageLiked()
            }
            
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        }
    }
}
