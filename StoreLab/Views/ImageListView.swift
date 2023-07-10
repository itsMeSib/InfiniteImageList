//
//  ImageListView.swift
//  StoreLab
//
//  Created by Shahzaib I. Bhatti on 06/07/2023.
//

import SwiftUI
import Combine

struct ImageListView: View {
    @StateObject var viewModel: ImageListViewModel
    
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                    ForEach(viewModel.images) { image in
                        NavigationLink(destination: ImageDetailPage(viewModel: ImageDetailViewModel(image: image))) {
                            ImageCell(viewModel: viewModel.getImageCellViewModel(image: image))
                                .onAppear {
                                    Task {
                                        if viewModel.shouldFetchNextPage(image) {
                                            await fetchData()
                                        }
                                    }
                                }
                        }
                    }
                }
                .padding()
                .task {
                    await fetchData()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Image List")
        }
    }
    
    private func fetchData() async {
        do {
            try await viewModel.fetchData()
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert = true
        }
    }
}
