//
//  String+Extension.swift
//  openBank
//
//  Created by Cristobal Ramos on 3/3/22.
//

import CryptoKit

extension String {
    func md5() -> String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
