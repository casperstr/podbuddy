//
//  PodcastItem.swift
//  podbuddy
//
//  Created by Casper Strömberg on 2019-10-31.
//  Copyright © 2019 Casper Strömberg. All rights reserved.
//

import Foundation
import SwiftUI


struct PodcastItem: View {
    var item: ItunesSearchAPIEntry
    @ObservedObject var image: RemoteImage
    
    init(item: ItunesSearchAPIEntry) {
        self.item = item
        image = RemoteImage(imageUrl: item.artworkUrl600)
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
        .padding(.horizontal)
        
    }
    
    
}


struct PodcastItem_Previews: PreviewProvider {
    static var previews: some View {
        PodcastItem(item: ItunesSearchAPIEntry(collectionId: 123, artistName: "Casper", trackName: "Strömberg", artworkUrl600: "https://is1-ssl.mzstatic.com/image/thumb/Podcasts113/v4/d4/41/a2/d441a2a0-4880-4840-9d8d-152e9b2b691e/mza_10005288361658681705.jpg/600x600bb.jpg"))
    }
}

