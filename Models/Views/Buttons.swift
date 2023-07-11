//
//  Buttons.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 04/07/2023.
//

import UIKit

extension UIButton
{
    convenience init(with text: String, backgroundColor: UIColor, textColor:UIColor, fontSize: CGFloat, cornerRadius:CGFloat? = 0, target: Any, action: Selector, tag:Int? = 0)
    {
        self.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.tag = tag!
        setTitle(text, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = self.titleLabel?.font.withSize(fontSize)
        
        titleLabel?.minimumScaleFactor = 0.5;
        titleLabel?.adjustsFontSizeToFitWidth = true;
        
        layer.cornerRadius = cornerRadius!

        addTarget(target, action: action, for: .touchUpInside)
    }
}
