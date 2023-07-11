//
//  BreedImage.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 04/07/2023.
//

import UIKit

public class BreedImage: Decodable
{
    public var id: String
    public var url: String
    public var image:UIImage
    
    public init()
    {
        id = ""
        url = ""
        image = UIImage()
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
    }
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        image = UIImage()
        
        if url != "" {
            
            guard let imageURL:URL = URL(string: self.url) else {return}
            let data = NSData(contentsOf: imageURL)
            
            DispatchQueue.main.async {
                if data != nil {
                    self.image = UIImage(data: data! as Data)!
                }
            }
        }
    }
}
