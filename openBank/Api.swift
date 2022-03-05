//
//  Api.swift
//  openBank
//
//  Created by Cristobal Ramos on 2/3/22.
//

import Foundation
class API {
    let url: URL
    init(url: URL) {
        self.url = url
    }
    func performRequest(_ completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: self.url, completionHandler: completion).resume()
    }
}
