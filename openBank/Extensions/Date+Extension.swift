//
//  Date+Extension.swift
//  openBank
//
//  Created by Cristobal Ramos on 3/3/22.
//

import Foundation

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
