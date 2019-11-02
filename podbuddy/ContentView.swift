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
                   TextField("Query", text: $networkingManager.query)
                   List(networkingManager.searchResults.results,id: \.collectionId) {
                                   item in
                                            PodcastItem(item: item)
                                    }
               }
               

          
       }

    
}

struct ContentView: View {
    
   
    @State var selection = 0
    var body: some View {
            TabView(selection: $selection){
                PodcastSearch().tabItem { Text("Search") }
                PodcastLibrary().tabItem { Text("Library") }
            }
            

       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
