//
//  BreedTemperamentCell.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 05/07/2023.
//

import UIKit

class BreedTemperamentCell: UICollectionViewCell
{
    let container:UIView = { let view = UIView(); view.backgroundColor = UIColor.darkBlue; view.layer.cornerRadius = 10; return view }()
    let breedTemperament = UILabel(fontSize: 12, textColor: UIColor.white, alignment: .center)
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        contentView.addSubview(container)
        container.addSubview(breedTemperament)
        
        container.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        breedTemperament.anchor(container.topAnchor, left: container.leftAnchor, bottom: container.bottomAnchor, right: container.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupCell(temperament:String){
        breedTemperament.text = temperament
    }
}


