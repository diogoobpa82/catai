//
//  FavCatBreedListVC.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 06/07/2023.
//

import UIKit

class FavCatBreedListVC: UIViewController
{
    var catBreeds:[CatBreed] = []
    var filteredBreeds:[CatBreed] = []
    
    var searchText = ""
    
    var filtered = false
    
    lazy var tableView = UITableView(cell: BreedCell.self, id: "BreedCell", delegate: self, dataSource: self, backgroundColor: .clear, separator: UITableViewCell.SeparatorStyle.none)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Fav Cat Breed List"
        
        setupViews()
        setupSearchBar()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupViews()
    {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.blue.cgColor, UIColor.lightBlue.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x : 0.0, y : 0.4)
        gradient.endPoint = CGPoint(x :0.0, y: 1.0) // you need to play with 0.15 to adjust gradient vertically
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        
        view.addSubview(tableView)
        
        tableView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupSearchBar(){
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
        
        if #available(iOS 13.0, *) {
            search.searchBar.searchTextField.backgroundColor = UIColor.white
        }
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
}

extension FavCatBreedListVC:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let countValue = filtered ? filteredBreeds.count : catBreeds.count
        if countValue == 0 { tableView.createTableEmptyLabel("No favorites yet") } else { tableView.backgroundView = UIView() }
        
        return countValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedCell", for: indexPath) as! BreedCell
        cell.backgroundColor = UIColor.clear
        cell.setupCell(filtered ? filteredBreeds[indexPath.row] : catBreeds[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let catBreed = filtered ? filteredBreeds[indexPath.row] : catBreeds[indexPath.row]
        catBreed.images.removeAll()
        catBreed.images.append(catBreed.image)
        
        let vc = CatBreedDetailVC()
        vc.catBreed = catBreed
        vc.delegate = self
        mainNavigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 236
    }

}

extension FavCatBreedListVC: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchText = ""
        filtered = false
        tableView.reloadData()
    }
}


extension FavCatBreedListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            self.searchText = ""
            filtered = false
            self.tableView.reloadData()
            return
        }
        
        filteredBreeds = catBreeds.filter{$0.name.lowercased().contains(searchText.lowercased())}
        
        filtered = true
        self.searchText = searchText
        self.tableView.reloadData()
    }
}

extension FavCatBreedListVC:CatBreedDetailVCDelegate{
    func favChanged() {
        self.catBreeds = catBreeds.filter{$0.favorite}
        self.tableView.reloadData()
    }
}
