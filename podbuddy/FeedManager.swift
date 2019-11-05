//
//  NetworkManager.swift
//  podbuddy
//
//  Created by Casper Strömberg on 2019-10-31.
//  Copyright © 2019 Casper Strömberg. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import FeedKit

enum NetworkError: Error {
    case url
    case server
}

class FeedManager : ObservableObject {
    @Environment(\.managedObjectContext) var managedObjectContext
    let objectWillChange = PassthroughSubject<FeedManager, Never>()

    func fetchImage(imageUrl: URL, callback: @escaping (Result<Data,NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: imageUrl) { (data,_,_) in
            var result: Result<Data, NetworkError>
            if let data = data {
                result = .success(data)
            } else {
                result = .failure(.server)
            }
            callback(result)
        }.resume()
    }
    
    func addChannel(feedUrl: URL) {
        let parser = FeedParser(URL: feedUrl)
        parser.parseAsync() { result in
           switch result {
               case .success(let feed):
                   switch feed {
                       case .rss(let rss):
                            guard let imageUrl = URL(string: rss.image?.url ?? "") else { return }
                  
                            self.fetchImage(imageUrl: imageUrl, callback: { image in
                                switch image {
                                   case let .success(data):
                                       let channel = PodcastChannel(context: self.managedObjectContext)
                                       channel.feedUrl = feedUrl
                                       channel.name = rss.title ?? ""
                                       channel.cover = data
                                       break;
                                   case .failure:
                                       break;
                                   }
                            })
                           
                            
                           
                            
                         
                           break;
                        case .atom:
                            break;
                       case .json:
                           break;

               }
               case .failure(let error):
                   print(error)
           }
        }
        do {
           try self.managedObjectContext.save()
        } catch {}
                   
    }
    
    
    
}
