//
//  PokemonListVC.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import UIKit

class PokemonListVC: UIViewController {
  private let cellIdentifier = "pokemonCell"
  private var collectionView: UICollectionView!
  private var _viewModel: PokemonListVM?
  private var viewModel: PokemonListVM {
    guard let vm = _viewModel else {
      return PokemonListVM(coordinator: AppCoordinator(with: UINavigationController()))
    }
    return vm
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Pokemon List"
    view.backgroundColor = .red
    createCollectionView()
    viewModel.pokemonList()
  }
  
  func config(with viewModel: PokemonListVM) {
    self._viewModel = viewModel
    self.viewModel.setPokemon(delegate: self)
  }
  
  private func createCollectionView() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    layout.itemSize = CGSize(width: 110, height: 110)
    layout.minimumLineSpacing = 5
    layout.minimumInteritemSpacing = 5
    layout.scrollDirection = .vertical
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(PokemonMainCell.self, forCellWithReuseIdentifier: cellIdentifier)
    self.view = collectionView
  }
  
}

extension PokemonListVC: UICollectionViewDelegate & UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PokemonMainCell
    cell.config(pokemon: viewModel.pokemon(at: indexPath))
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.showDetail(by: indexPath)
  }
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    
    if offsetY > contentHeight - scrollView.frame.size.height {
      viewModel.pokemonList()
    }
  }
  
}

extension PokemonListVC: PokemonListViewModelProtocol {
  func fetch(_ error: Error?) {
    guard error == nil else {
      let alert = UIAlertController(title: "Error", message: "Error", preferredStyle: .alert)
      let action = UIAlertAction(title: "OK", style: .default)
      alert.addAction(action)
      self.present(alert, animated: true)
      return
    }
    if let start = viewModel.initialFrame, let end = viewModel.endFrame {
      let map = (start...end).map { IndexPath(item: $0, section: 0)}
      collectionView.reloadItems(at: map)
    } else {
      collectionView.reloadData()
    }
  }
}
