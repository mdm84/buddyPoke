//
//  PokemonMainCell.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import UIKit

class PokemonMainCell: UICollectionViewCell {
  let backview: UIView = {
    let view = UIView()
    view.layer.borderColor = UIColor.blue.cgColor
    view.layer.borderWidth = 1.0
    view.layer.cornerRadius = 8.0
    view.layer.masksToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let name: UILabel = {
    let label = UILabel()
    label.textColor = .red
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let avatar: UIImageView = {
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func config(pokemon: Pokemon) {
    print(pokemon.name)
    name.text = pokemon.name
    name.sizeToFit()
    name.textAlignment = .center
    name.backgroundColor = .blue
    if let pokestring = (pokemon.sprites?.other?.official?.front), let url = URL(string: pokestring) {
      avatar.load(url: url)
    }
    addView()
  }
  
  private func addView() {
    addSubview(backview)
    backview.leftAnchor.constraint(equalTo: leftAnchor, constant: 4).isActive = true
    backview.rightAnchor.constraint(equalTo: rightAnchor, constant: 4).isActive = true
    backview.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
    backview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4).isActive = true
    
    backview.addSubview(name)
    name.leftAnchor.constraint(equalTo: backview.leftAnchor, constant: 8).isActive = true
    name.rightAnchor.constraint(equalTo: backview.rightAnchor, constant: -8).isActive = true
    name.bottomAnchor.constraint(equalTo: backview.bottomAnchor, constant: -8).isActive = true
    name.heightAnchor.constraint(equalToConstant: 21.0).isActive = true
    
    backview.addSubview(avatar)
    avatar.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
    avatar.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    avatar.topAnchor.constraint(equalTo: backview.topAnchor, constant: 16.0).isActive = true
    avatar.centerXAnchor.constraint(equalTo: backview.centerXAnchor).isActive = true
  }
  
  override func prepareForReuse() {
    name.text = ""
    avatar.image = nil
  }
  
}
