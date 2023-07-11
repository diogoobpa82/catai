//
//  UILabel.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 04/07/2023.
//

import UIKit

extension UILabel
{
    //Normal
    convenience init (fontSize: CGFloat, textColor: UIColor, backgroundColor: UIColor? = .clear, cornerRadius: CGFloat? = 0, alignment: NSTextAlignment? = .left, lines: Int? = 0, text: String? = "")
    {
        self.init(frame: .zero)
        
        self.font = self.font.withSize(fontSize)
        self.textColor = textColor
        self.backgroundColor = backgroundColor!
        self.textAlignment = alignment!
        self.numberOfLines = lines!
        self.text = text!
        self.minimumScaleFactor = lines! == 1 ? 0.3 : 0;
        self.adjustsFontSizeToFitWidth = lines! == 1;
        self.layer.cornerRadius = cornerRadius!
        self.clipsToBounds = true
    }
}
