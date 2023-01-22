//
//  PokemonDetailVC.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import UIKit

class PokemonDetailVC: UITableViewController {
  private let cellIdentifier = "detailCell"
  private var viewModel: PokemonDetailVM?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
  }
  
  func config(viewModel: PokemonDetailVM) {
    self.viewModel = viewModel
    self.title = viewModel.title
  }
  
  // MARK: - Table view data source
  // Should replace old tableview version with diffable protocol (need to implement Hashable for row and sections
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel?.rows ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.text = viewModel?.getInfo(at: indexPath.row).value
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }

}
