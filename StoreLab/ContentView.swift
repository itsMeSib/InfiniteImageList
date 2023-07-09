//
//  ContentView.swift
//  StoreLab
//
//  Created by Shahzaib I. Bhatti on 06/07/2023.
//
import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured
    enum Tab {
        case featured
        case list
    }

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                ImageListView(viewModel: ImageListViewModel())
                    .tabItem {
                        Label("List", systemImage: "list.bullet")
                    }
                    .tag(Tab.featured)
                
                FavoriteImageList(viewModel: FavouriteImageListViewModel())
                    .tabItem {
                        Label("Favourite", systemImage: "star")
                    }
                    .tag(Tab.list)
            }
            .navigationBarTitle("Infinite Image List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
