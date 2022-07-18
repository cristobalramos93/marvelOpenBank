//
//  CharacterDetailViewController.swift
//  openBank
//
//  Created by Cristobal Ramos on 4/3/22.
//

import Foundation
import UIKit
import Kingfisher

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var returnImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet private weak var characterImageView: UIImageView!
    
    private var character: CharacterData?
    
    override func viewDidLoad() {
        self.setReturnImageView()
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    func setupView(_ character: CharacterData) {
        self.character = character
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
        guard let character = self.character, let description = character.description else { return }
        if !(description.isEmpty) {
            let descriptionView: DetailView = UIView.fromNib()
            descriptionView.setView(title: "Description", subtitle: description)
            self.stackView.addArrangedSubview(descriptionView)
        }
    }
    
    func addComicView() {
        guard let character = self.character, let comics = character.comics else { return }
        let comicView: DetailView = UIView.fromNib()
        comicView.setView(title: "Comics avaible", subtitle: String(comics))
        self.stackView.addArrangedSubview(comicView)
    }
    
    func addStorieView() {
        guard let character = self.character, let stories = character.stories else { return }
        let storieView: DetailView = UIView.fromNib()
        storieView.setView(title: "Stories avaible", subtitle: String(stories))
        self.stackView.addArrangedSubview(storieView)
    }
    
    func addEventView() {
        guard let character = self.character, let events = character.events else { return }
        let eventView: DetailView = UIView.fromNib()
        eventView.setView(title: "Event avaible", subtitle: String(events))
        self.stackView.addArrangedSubview(eventView)
    }
    
    func addSerieView() {
        guard let character = self.character, let series = character.series else { return }
        let serieView: DetailView = UIView.fromNib()
        serieView.setView(title: "Serie avaible", subtitle: String(series))
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
        guard let character = self.character, let imageUrl = character.imageUrl else { return }
        self.characterImageView.layer.cornerRadius = self.characterImageView.frame.height / 2
        self.characterImageView.clipsToBounds = true
        self.characterImageView.contentMode = .scaleAspectFill
        let url = URL(string: imageUrl)
        self.characterImageView.kf.setImage(with: url)
    }
}
