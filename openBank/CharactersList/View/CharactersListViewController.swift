//
//  CharactersList.swift
//  openBank
//
//  Created by Cristobal Ramos on 2/3/22.
//

import UIKit
import Lottie

protocol CharactersListViewProtocol: AnyObject {
    func showCharacters(_ characters: [CharactersList])
    func goToCharacterDetail(_ character: Character)
    func showError()
}

class CharactersListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var reloadButton: UIButton!
    @IBOutlet private weak var errorView: AnimationView!
    
    private var charactersList: [CharactersList] = []
    lazy var presenter = CharactersListPresenter(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.presenter.viewDidLoad()
        self.errorView.isHidden = true
        self.reloadButton.isHidden = true
    }
    @IBAction func didTapOnReload(_ sender: Any) {
        self.presenter.viewDidLoad()
    }
}

private extension CharactersListViewController {
    func setTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let nib = UINib(nibName: "CharacterCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CharacterCell")
    }
}

extension CharactersListViewController: CharactersListViewProtocol {
    func goToCharacterDetail(_ character: Character) {
        let viewController = CharacterDetailViewController.initFromNib()
        viewController.modalPresentationStyle = .fullScreen
        viewController.character = character
        self.present(viewController, animated: true, completion: nil)
    }
    
    func showCharacters(_ characters: [CharactersList]) {
        if characters.isEmpty {
            self.showError()
        } else {
            self.charactersList = characters
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.errorView.isHidden = true
            self.reloadButton.isHidden = true
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.errorView.isHidden = false
            self.reloadButton.isHidden = false
            self.errorView.contentMode = .scaleAspectFit
            self.errorView.play()
            self.errorView.loopMode = .loop
        }
    }
}


extension CharactersListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charactersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterCell {
            let imageUrl = self.charactersList[indexPath.row].thumbnail.path + "." + self.charactersList[indexPath.row].thumbnail.thumbnailExtension.rawValue
            cell.setup(imageUrl: imageUrl, name: self.charactersList[indexPath.row].name)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.loadCharacter(self.charactersList[indexPath.row].id)
    }
}
