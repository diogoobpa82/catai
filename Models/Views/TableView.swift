//
//  TableView.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 04/07/2023.
//

import UIKit

extension UITableView
{
    convenience init(style: UITableView.Style? = .plain, cell: UITableViewCell.Type, id: String, delegate: UITableViewDelegate, dataSource: UITableViewDataSource, backgroundColor: UIColor, separator: UITableViewCell.SeparatorStyle? = UITableViewCell.SeparatorStyle.none, separatorColor: UIColor? = UIColor.gray, bounces: Bool? = true, tag: Int? = 0)
    {
        self.init(frame: .zero, style: style!)
        
        self.register(cell, forCellReuseIdentifier: id)
        self.delegate = delegate
        self.dataSource = dataSource
        self.backgroundColor = backgroundColor
        self.separatorStyle = separator ?? .none
        self.separatorColor = separatorColor!
        self.bounces = bounces!
        self.tableFooterView = UIView()
        self.tag = tag!
        
        allowsMultipleSelection = false
    }
    
    func createTableEmptyLabel(_ labelText: String, color: UIColor? = .black)
    {
        let label: UILabel     = UILabel(frame: CGRect(x: 0, y: 30, width: bounds.size.width,height: bounds.size.height))
        
        label.text             = labelText
        label.font             = label.font.withSize(14)
        label.textColor        = color
        label.textAlignment    = .center
        label.tag = 100
        
        backgroundView = label
    }
}
