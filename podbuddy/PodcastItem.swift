//
//  PodcastItem.swift
//  podbuddy
//
//  Created by Casper Strömberg on 2019-10-31.
//  Copyright © 2019 Casper Strömberg. All rights reserved.
//

import Foundation
import SwiftUI
import FeedKit


struct PodcastItem: View {
    var item: ItunesSearchAPIEntry
    @ObservedObject var image: RemoteImage
    @ObservedObject var feedManager: FeedManager
    @Environment(\.managedObjectContext) var managedObjectContext
    
    init(item: ItunesSearchAPIEntry) {
        self.item = item
        image = RemoteImage(imageUrl: item.artworkUrl600)
        feedManager = FeedManager()
    }
 
    
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .leading){
                Text(item.artistName)
                Text(item.trackName)
               
            }
            Spacer()
            Image(uiImage: (image.data.isEmpty) ? UIImage() : UIImage(data: image.data)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.trailing)
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                
                
        }
        .padding(.horizontal).onTapGesture {
            guard let feedUrl = URL(string: self.item.feedUrl) else { return }
            self.feedManager.addChannel(feedUrl: feedUrl)
            
        }
        
    }
    
    
}

