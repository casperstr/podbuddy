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

final class NetworkManager : ObservableObject {
    let objectWillChange = PassthroughSubject<NetworkManager, Never>()
    
    var isLoading: Bool {
        get{
            self.currentRequest != nil
        }
    }
 
   private var currentRequest: URLSessionDataTask?{
        didSet {
            objectWillChange.send(self)
        }
    }
    
    var searchResults = ITunesSearchAPIList(results: []){
        willSet {
            objectWillChange.send(self)
        }
    }
    
    var query = "" { 
        didSet {
            searchItems(searchQuery: query)
        }
    }
        
    func searchItems(searchQuery: String) {
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=" + searchQuery + "&country=SE&media=podcast&entity=podcast") else { return }
   
        self.currentRequest?.cancel()
   
        let request = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return }
            let searchResults = try? JSONDecoder().decode(ITunesSearchAPIList.self, from: data)
            
            if let searchResults = searchResults {
                DispatchQueue.main.async {
                    self.searchResults = searchResults
                    self.currentRequest = nil
                }
            } else {
                DispatchQueue.main.async {
                    self.searchResults = ITunesSearchAPIList(results: [ItunesSearchAPIEntry]())
                    self.currentRequest = nil
                }
            }
            
        }
        self.currentRequest = request;
        request.resume();
       
    
    }
    
    
}
