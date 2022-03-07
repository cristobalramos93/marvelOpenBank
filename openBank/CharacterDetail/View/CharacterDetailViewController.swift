//
//  CharacterDetailViewController.swift
//  openBank
//
//  Created by Cristobal Ramos on 4/3/22.
//

import Foundation
import UIKit

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var returnImageView: UIImageView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var characterImageView: UIImageView!
    
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setReturnImageView()
        self.setViews()
        self.setImageView()
    }
}

private extension CharacterDetailViewController {
    func setViews() {
        self.addNameView()
        self.addDescriptionView()
        self.addComicView()
        self.addEventView()
        self.addSerieView()
        self.addStorieView()
    }
    
    func addNameView() {
        guard let character = self.character else { return }
        let nameView: DetailView = UIView.fromNib()
        nameView.setView(title: "Name", subtitle: character.name)
        self.stackView.addArrangedSubview(nameView)
    }
    
    func addDescriptionView() {
        guard let character = self.character else { return }
        if !character.resultDescription.isEmpty {
            let descriptionView: DetailView = UIView.fromNib()
            descriptionView.setView(title: "Description", subtitle: character.resultDescription)
            self.stackView.addArrangedSubview(descriptionView)
        }
    }
    
    func addComicView() {
        guard let character = self.character else { return }
        let comicView: DetailView = UIView.fromNib()
        comicView.setView(title: "Comics avaible", subtitle: String(character.comics.available))
        self.stackView.addArrangedSubview(comicView)
    }
    
    func addStorieView() {
        guard let character = self.character else { return }
        let storieView: DetailView = UIView.fromNib()
        storieView.setView(title: "Stories avaible", subtitle: String(character.stories.available))
        self.stackView.addArrangedSubview(storieView)
    }
    
    func addEventView() {
        guard let character = self.character else { return }
        let eventView: DetailView = UIView.fromNib()
        eventView.setView(title: "Event avaible", subtitle: String(character.events.available))
        self.stackView.addArrangedSubview(eventView)
    }
    
    func addSerieView() {
        guard let character = self.character else { return }
        let serieView: DetailView = UIView.fromNib()
        serieView.setView(title: "Serie avaible", subtitle: String(character.series.available))
        self.stackView.addArrangedSubview(serieView)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    func setReturnImageView() {
        self.returnImageView.image = UIImage(named: "back")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.returnImageView.isUserInteractionEnabled = true
        self.returnImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setImageView() {
        self.characterImageView.layer.cornerRadius = self.characterImageView.frame.height / 2
        self.characterImageView.clipsToBounds = true
        self.characterImageView.contentMode = .scaleAspectFill
        guard let character = self.character else { return }
        let url = character.thumbnail.path + "." + character.thumbnail.thumbnailExtension
        self.characterImageView.loadFrom(URLAddress: url)
    }
}
