//
//  CatBreedDetailVC.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 05/07/2023.
//

import UIKit

protocol CatBreedDetailVCDelegate{
    func favChanged()
}

class CatBreedDetailVC: UIViewController
{
    var delegate:CatBreedDetailVCDelegate!
    
    var catBreed:CatBreed = CatBreed()
    
    var temperament:[String] = []
    
    let container:UIView = { let view = UIView(); view.backgroundColor = UIColor.white; view.layer.cornerRadius = 10; return view }()
    
    let breedName = UILabel(fontSize: 20, textColor: UIColor.black, alignment: .left)
    let breedOrg = UILabel(fontSize: 14, textColor: UIColor.gray, alignment: .left)
    let breedLifeSpan = UILabel(fontSize: 14, textColor: UIColor.gray, alignment: .left)
    let breedTemperament = UILabel(fontSize: 14, textColor: UIColor.gray, alignment: .left)
    lazy var breedDescription = UITextView(fontSize: 12, color: UIColor.gray, isSelectable: false, isEditable: false, withBorder: false, keyboardType: .default, returnKey: .done)
    
    lazy var addBtn = UIButton(with: "Add to Favorites", backgroundColor: UIColor.green1, textColor: UIColor.black.withAlphaComponent(0.7),fontSize: 14, target: self, action: #selector(favAction1))
    
    lazy var rmvBtn = UIButton(with: "Remove from Favorites", backgroundColor: UIColor.lightGray.withAlphaComponent(0.8), textColor: UIColor.white,fontSize: 14, target: self, action: #selector(favAction2))
    
    let image : UIImageView = {let imageView = UIImageView(); return imageView}()
    
    let imageFav: UIImageView = {let imageView = UIImageView(); return imageView}()
    
    let favorite = UIImage(systemName: "star.fill")?.withTintColor(.green1, renderingMode: .alwaysOriginal)
    let no_favorite = UIImage(systemName: "star")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
    
    let globe = UIImage(systemName: "globe")?.withTintColor(.darkBlue, renderingMode: .alwaysOriginal)
    let globeImg : UIImageView = {let imageView = UIImageView(); return imageView}()
    
    let cake = UIImage(systemName: "birthday.cake")?.withTintColor(.darkBlue, renderingMode: .alwaysOriginal)
    let cakeImg : UIImageView = {let imageView = UIImageView(); return imageView}()
    
    var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = catBreed.name
        
        setupCollectionView()
        
        setupViews()
        setupBreed()
        setupNavBar()
    }
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BreedTemperamentCell.self, forCellWithReuseIdentifier: "BreedTemperamentCell")
    }
    
    
    func setupViews()
    {
        imageFav.contentMode = .scaleAspectFill
        
        rmvBtn.layer.cornerRadius = 10
        addBtn.layer.cornerRadius = 10
        
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.blue.cgColor, UIColor.lightBlue.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x : 0.0, y : 0.8)
        gradient.endPoint = CGPoint(x :0.0, y: 1.0) // you need to play with 0.15 to adjust gradient vertically
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        
        globeImg.image = globe
        globeImg.contentMode = .scaleAspectFill
        
        cakeImg.image = cake
        cakeImg.contentMode = .scaleAspectFill
        
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 10
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image.layer.masksToBounds = true
        
        view.addSubview(container)
        
        container.addSubview(image)
        
        container.addSubview(breedName)
        container.addSubview(globeImg)
        container.addSubview(breedOrg)
        container.addSubview(cakeImg)
        container.addSubview(breedLifeSpan)
        container.addSubview(collectionView)
        container.addSubview(breedDescription)
        container.addSubview(imageFav)
        
        view.addSubview(addBtn)
        view.addSubview(rmvBtn)
        
        container.anchor(view.topAnchor, left: view.leftAnchor, bottom: addBtn.topAnchor, right: view.rightAnchor, topConstant: 100, leftConstant: 20, bottomConstant: 20, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        image.anchor(container.topAnchor, left: container.leftAnchor, bottom: nil, right: container.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 270)
        
        breedName.anchor(image.bottomAnchor, left: image.leftAnchor, bottom: nil, right: image.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 24)
        
        globeImg.anchor(breedName.bottomAnchor, left: breedName.leftAnchor, bottom: nil, right: nil, topConstant: 7, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 16, heightConstant: 16)
        
        breedOrg.anchor(breedName.bottomAnchor, left: globeImg.rightAnchor, bottom: nil, right: breedName.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        cakeImg.anchor(breedOrg.bottomAnchor, left: breedName.leftAnchor, bottom: nil, right: nil, topConstant: 7, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 16, heightConstant: 16)
        
        breedLifeSpan.anchor(breedOrg.bottomAnchor, left: cakeImg.rightAnchor, bottom: nil, right: breedName.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        breedDescription.anchor(breedLifeSpan.bottomAnchor, left: breedName.leftAnchor, bottom: nil, right: breedName.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 100)
        
        collectionView.anchor(breedDescription.bottomAnchor, left: breedName.leftAnchor, bottom: imageFav.topAnchor, right: breedName.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        imageFav.anchor(nil, left: nil, bottom: container.bottomAnchor, right: container.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 20, widthConstant: 24, heightConstant: 24)
        
        rmvBtn.anchor(nil, left: container.leftAnchor, bottom: view.bottomAnchor, right: container.centerXAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 30, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        addBtn.anchor(nil, left: container.centerXAnchor, bottom: rmvBtn.bottomAnchor, right: container.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }
    
    func setupBreed(){
        breedName.text = catBreed.name
        breedOrg.text = catBreed.origin
        breedLifeSpan.text = catBreed.lifeSpan
        breedTemperament.text = catBreed.temperament
        breedDescription.text = catBreed.description
        image.image = catBreed.image
        imageFav.image = catBreed.favorite ? favorite : no_favorite
        temperament = catBreed.temperament.components(separatedBy: ",")
    }
    
    func setupNavBar(){
        let item = UIBarButtonItem(customView: createItemForNavigationBar(image: UIImage(systemName: "arrow.backward")!, target: self, action: #selector(pop)))
        navigationItem.leftBarButtonItem = item
    }
    
    @objc func pop(){
        mainNavigationController?.popViewController(animated: true)
    }
    
    func createItemForNavigationBar(image: UIImage, tintColor: UIColor? = UIColor.darkBlue, backgroundColor: UIColor? = UIColor.lightBlue, target: Any, action: Selector) -> UIButton
    {
        let button = UIButton()
        button.backgroundColor = backgroundColor!
        button.frame = CGRect(x: 0, y: 0, width: 38, height: 38)
        button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.layer.cornerRadius = 10
        button.imageView?.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = tintColor!
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    
    @objc func favAction1()
    {
        favAction(newState: true)
    }
    
    @objc func favAction2()
    {
        favAction(newState: false)
    }
    
    func favAction(newState:Bool)
    {
        catBreed.favorite = newState
        
        imageFav.image = catBreed.favorite ? favorite : no_favorite
        
        favCatBreeds.removeAll()
        
        for breed in catBreeds{
            if breed.favorite{
                favCatBreeds.append(breed.id)
            }
        }
        
        apiCalls.saveArrayToFile(array: favCatBreeds, filename: "fav.txt")
        
        delegate.favChanged()
    }
}

extension CatBreedDetailVC: UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return temperament.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreedTemperamentCell", for: indexPath) as! BreedTemperamentCell
        cell.setupCell(temperament: temperament[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return  CGSize(width: (collectionView.bounds.width/3) - 10, height: 40)
    }
}
