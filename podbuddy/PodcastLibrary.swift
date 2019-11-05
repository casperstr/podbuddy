//
//  PodcastLibrary.swift
//  podbuddy
//
//  Created by Casper Strömberg on 2019-10-31.
//  Copyright © 2019 Casper Strömberg. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

struct PodcastLibrary : View {
    @FetchRequest(
        entity: PodcastChannel.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \PodcastChannel.name, ascending: true)]
    ) var podcasts: FetchedResults<PodcastChannel>
   
    var body: some View {
        HStack {
            List(podcasts, id: \.feedUrl) { podcast in
                Text(podcast.name ?? "")
            }
            Text("Whattup")
        }
        
    }
}




struct PodcastLibrary_Previews: PreviewProvider {
    static var previews: some View {
       PodcastLibrary()
    }
}

