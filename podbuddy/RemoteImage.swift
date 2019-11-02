//
//  RemoteImage.swift
//  podbuddy
//
//  Created by Casper Strömberg on 2019-10-31.
//  Copyright © 2019 Casper Strömberg. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class RemoteImage: ObservableObject {

    let objectWillChange = PassthroughSubject<RemoteImage, Never>()
        
    var data = Data() {
        willSet {
            objectWillChange.send(self)
        }
    }
    init(imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
    

}
