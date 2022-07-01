//
//  CharacterCell.swift
//  openBank
//
//  Created by Cristobal Ramos on 3/3/22.
//

import Foundation
import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.characterImageView.image = nil
    }
    
    func setup(imageUrl: String, name: String) {
        self.nameLabel.text = name
        self.characterImageView.layer.cornerRadius = self.characterImageView.frame.height / 2
        self.characterImageView.clipsToBounds = true
        self.characterImageView.contentMode = .scaleAspectFill
        self.characterImageView.loadFrom(URLAddress: imageUrl)
    }
}
