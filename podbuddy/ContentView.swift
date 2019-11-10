//
//  ContentView.swift
//  podbuddy
//
//  Created by Casper Strömberg on 2019-10-31.
//  Copyright © 2019 Casper Strömberg. All rights reserved.
//

import SwiftUI




struct PodcastSearch: View {
     @ObservedObject var networkingManager = NetworkManager()
    var body: some View {
        VStack{
            HStack{
                TextField("Query", text: $networkingManager.query)
                ActivityIndicator(isAnimating: self.networkingManager.isLoading, style: UIActivityIndicatorView.Style.medium)
            }.padding()
            
            List(networkingManager.searchResults.results,id: \.collectionId) { item in
                PodcastItem(item: item)
            }
        }
            
    }

    
}

struct ContentView: View {

    var body: some View {
            TabView{
                PodcastLibrary().tabItem { Text("Library") }
                PodcastSearch().tabItem { Text("Search") }
            }
            

       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
