//
//  PodcastLibrary.swift
//  podbuddy
//
//  Created by Casper Strömberg on 2019-10-31.
//  Copyright © 2019 Casper Strömberg. All rights reserved.
//

import Foundation
import MediaPlayer
import SwiftUI

struct PodcastLibrary : View {
    

    
    init(){
        MPMediaLibrary.requestAuthorization{_ in
            print("TJENA")
            guard let pods = MPMediaQuery.podcasts().items else { return }
                   for pod in pods {
                       print(pod.albumArtist)
                   }
        }
       
           
    }
    
   
    var body: some View {
        Text("Podder")
    }
}




