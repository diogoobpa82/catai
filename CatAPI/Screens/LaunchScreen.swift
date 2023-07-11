//
//  LaunchScreen.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 04/07/2023.
//

import UIKit
import Network

class LaunchScreen: UIViewController
{
    lazy var listBtn = UIButton(with: "Cat Breed List", backgroundColor: UIColor.darkBlue.withAlphaComponent(0.5), textColor: UIColor.white,fontSize: 14, target: self, action: #selector(listTapped))
    
    lazy var favBtn = UIButton(with: "Favorite Cat Breed List", backgroundColor: UIColor.darkBlue.withAlphaComponent(0.5), textColor: UIColor.white,fontSize: 14, target: self, action: #selector(favlistTapped))
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = ""
        
        setupNavbarStyle()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    func setupNavbarStyle(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.blue
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
       
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    @objc func listTapped(){
        let vc = CatBreedListVC()
        mainNavigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func favlistTapped(){
        let vc = FavCatBreedListVC()
        vc.catBreeds = catBreeds.filter{$0.favorite}
        mainNavigationController?.pushViewController(vc, animated: true)
    }
    
    func setupViews()
    {
        listBtn.layer.cornerRadius = 10
        favBtn.layer.cornerRadius = 10
        
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.blue.cgColor, UIColor.lightBlue.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x : 0.0, y : 0.4)
        gradient.endPoint = CGPoint(x :0.0, y: 1.0) // you need to play with 0.15 to adjust gradient vertically
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        
        view.addSubview(listBtn)
        view.addSubview(favBtn)
        
        listBtn.anchor(view.centerYAnchor, left: view.centerXAnchor, bottom: nil, right: nil, topConstant: -60, leftConstant: -100, bottomConstant: 0, rightConstant: 0, widthConstant: 200, heightConstant: 50)
        
        favBtn.anchor(listBtn.bottomAnchor, left: listBtn.leftAnchor, bottom: nil, right: listBtn.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }
}
