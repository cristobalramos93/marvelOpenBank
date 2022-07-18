//
//  CharactersList.swift
//  openBank
//
//  Created by Cristobal Ramos on 2/3/22.
//

import UIKit
import Lottie

protocol CharactersListViewProtocol: AnyObject {
    func showCharacters(_ characters: [CharacterData])
    func goToCharacterDetail(_ character: CharacterData)
    func showError()
    func setTotalCharacters(_ totalCharacters: Int)
}

class CharactersListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var errorView: AnimationView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loaderView: AnimationView!
    
    var charactersList: [CharacterData] = []
    var presenter: CharactersListPresenterProtocol?
    private var characterDetailViewController = CharacterDetailViewController.initFromNib()
    private var totalCharacters = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setErrorView()
        self.setLoaderAnimationView()
        self.setLoadingView()
        self.presenter?.viewDidLoad()
    }
    
    @IBAction private func didTapOnReload(_ sender: Any) {
        self.presenter?.viewDidLoad()
    }
}

private extension CharactersListViewController {
    func setTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let nib = UINib(nibName: "CharacterCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CharacterCell")
    }
    
    func showLoading() {
        self.loaderView.isHidden = false
        self.loaderView.play()
    }
    
    func dismissLoading() {
        self.loaderView.isHidden = true
        self.loaderView.stop()
    }
    
    func setLoaderAnimationView() {
        self.loaderView.isHidden = true
        self.loaderView.backgroundColor = .clear
        self.loaderView.loopMode = .loop
        self.loaderView.contentMode = .scaleAspectFit
    }
    
    func setErrorView() {
        self.errorView.isHidden = true
        self.reloadButton.isHidden = true
        self.errorView.contentMode = .scaleAspectFit
        self.errorView.loopMode = .loop
    }
    
    func setLoadingView() {
        self.loadingView.isHidden = true
        self.loadingView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
}

extension CharactersListViewController: CharactersListViewProtocol {
    func goToCharacterDetail(_ character: CharacterData) {
        self.characterDetailViewController.modalPresentationStyle = .fullScreen
        self.present(self.characterDetailViewController, animated: true, completion: nil)
        self.characterDetailViewController.setupView(character)
    }
    
    func showCharacters(_ characters: [CharacterData]) {
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
            self.tableView.isHidden = true
            self.errorView.isHidden = false
            self.reloadButton.isHidden = false
            self.errorView.play()
    }
    
    func setTotalCharacters(_ totalCharacters: Int) {
        self.totalCharacters = totalCharacters
    }
}


extension CharactersListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charactersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterCell {
            let imageUrl = self.charactersList[indexPath.row].imageUrl ?? ""
            cell.setup(imageUrl: imageUrl, name: self.charactersList[indexPath.row].name)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.loadCharacter(self.charactersList[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.charactersList.count - 1 {
            if charactersList.count < self.totalCharacters {
                self.showLoading()
                self.loadingView.isHidden = false
                self.presenter?.reloadCharacterList(offset: self.charactersList.count, characterList: self.charactersList) {
                    self.loadingView.isHidden = true
                    self.dismissLoading()
                }
            }
        }
    }
}
