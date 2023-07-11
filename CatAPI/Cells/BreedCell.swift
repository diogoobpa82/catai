//
//  BreedCell.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 04/07/2023.
//

import UIKit

class BreedCell: UITableViewCell
{
    let container:UIView = { let view = UIView(); view.backgroundColor = UIColor.white; view.layer.cornerRadius = 10; return view }()
    
    let breedName = UILabel(fontSize: 16, textColor: UIColor.black, alignment: .left)
    let breedOrg = UILabel(fontSize: 14, textColor: UIColor.black.withAlphaComponent(0.7), alignment: .left)
    
    let image : UIImageView = {let imageView = UIImageView(); return imageView}()
    
    let imageFav: UIImageView = {let imageView = UIImageView(); return imageView}()
    
    let favorite = UIImage(systemName: "star.fill")?.withTintColor(.green1, renderingMode: .alwaysOriginal)
    let no_favorite = UIImage(systemName: "star")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews()
    {
        imageFav.contentMode = .scaleAspectFill
        
        selectionStyle = .none
        
        contentView.addSubview(container)
        container.addSubview(image)
        container.addSubview(breedName)
        container.addSubview(breedOrg)
        container.addSubview(imageFav)
        
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 10
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image.layer.masksToBounds = true
        
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.4
        container.layer.shadowOffset = .zero
        container.layer.shadowRadius = 2
        
        container.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 10, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        image.anchor(container.topAnchor, left: container.leftAnchor, bottom: nil, right: container.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 150)
        
        breedName.anchor(container.topAnchor, left: container.leftAnchor, bottom: nil, right: container.rightAnchor, topConstant: 160, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 20)
        
        breedOrg.anchor(breedName.bottomAnchor, left: breedName.leftAnchor, bottom: nil, right: breedName.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 16)
        
        imageFav.anchor(image.bottomAnchor, left: nil, bottom: nil, right: container.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 24, heightConstant: 24)
    
    }
    
    func setupCell(_ breed: CatBreed)
    {
        breedName.text = "Name: \(breed.name)"
        breedOrg.text = "Origin: \(breed.origin)"
        
        image.image = breed.image
        
        imageFav.image = breed.favorite ? favorite : no_favorite
    }
}
