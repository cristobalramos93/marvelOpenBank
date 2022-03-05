//
//  DetailView.swift
//  openBank
//
//  Created by Cristobal Ramos on 5/3/22.
//

import Foundation
import UIKit

class DetailView: UIView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    func setView(title: String, subtitle: String) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.titleLabel.textColor = .gray
    }
}
