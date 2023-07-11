//
//  TextView.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 07/07/2023.
//

import UIKit

extension UITextView
{
    convenience init(text: String? = "",fontSize: CGFloat, background: UIColor? = .clear, color: UIColor? = .black, cornerRadius: CGFloat? = 0, isSelectable: Bool? = true, isEditable: Bool? = true, withBorder: Bool? = false, keyboardType: UIKeyboardType, returnKey: UIReturnKeyType)
    {
        self.init(frame: .zero, textContainer: nil)
        
        backgroundColor = background!
        textColor = color
        textAlignment = .justified
        bounces = false
        showsVerticalScrollIndicator = false
 
        self.keyboardType = keyboardType
        self.returnKeyType = returnKey
        self.isSelectable = isSelectable!
        self.isEditable = isEditable!
        self.font = self.font?.withSize(fontSize)
        self.text = text
        self.layer.cornerRadius = cornerRadius!
        if withBorder!
        {
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 1.0
        }
        
        textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
