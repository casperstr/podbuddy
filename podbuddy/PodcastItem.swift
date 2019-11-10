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
                    .font(.system(.subheadline))
                Text(item.trackName)
                    .lineLimit(2).font(.system(.headline)).padding(.trailing)
               
            }
            Spacer()
            Image(uiImage: (image.data.isEmpty) ? UIImage(imageLiteralResourceName: "Unknown.png") : UIImage(data: image.data)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape( RoundedRectangle(cornerRadius: 5))
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                )
               
                
                
                
        }
        .padding().onTapGesture {
            guard let feedUrl = URL(string: self.item.feedUrl) else { return }
            self.feedManager.addChannel(feedUrl: feedUrl)
            
        }
        
    }
    
    
}


struct PodcastItem_Previews: PreviewProvider {
    static var previews: some View {
        PodcastItem(item: ItunesSearchAPIEntry(collectionId: 1, artistName: "Sveriges Radio", trackName: "Vredens konflikt en serie i tre delar om saker", feedUrl: "https://google.se", artworkUrl600: "https://www.hackingwithswift.com/img/home-find-answers@2x.jpg"))
    }
}
