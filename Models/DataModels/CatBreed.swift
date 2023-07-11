//
//  CatBreed.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 04/07/2023.
//

import UIKit

public class CatBreed: Decodable,Encodable
{
    public var id: String
    public var name: String
    public var origin: String
    public var imgUrl:String
    public var lifeSpan:String
    public var temperament:String
    public var description:String
    
    public var image:UIImage
    
    public var images:[UIImage]
    
    public var favorite:Bool = false
    
    public init()
    {
        id = ""
        name = ""
        origin = ""
        imgUrl = ""
        lifeSpan = ""
        temperament = ""
        description = ""
        image = UIImage()
        images = [UIImage()]
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case origin
        case reference_image_id
        case life_span
        case temperament
        case description
        case savedImg
        case is_favorite
    }
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        origin = try container.decodeIfPresent(String.self, forKey: .origin) ?? ""
        imgUrl = try container.decodeIfPresent(String.self, forKey: .reference_image_id) ?? ""
        lifeSpan = try container.decodeIfPresent(String.self, forKey: .life_span) ?? ""
        temperament = try container.decodeIfPresent(String.self, forKey: .temperament) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        favorite = try container.decodeIfPresent(Bool.self, forKey: .is_favorite) ?? false
        
        let imageData = try container.decodeIfPresent(Data.self, forKey: .savedImg) ?? Data()
        let decodedImage = UIImage(data: imageData) ?? UIImage()
        
        let defaultImg = UIImage(systemName: "photo")?.withTintColor(.darkBlue, renderingMode: .alwaysOriginal)
        let imageOnline = defaultImg ?? UIImage()
        
        image = isConnected ? imageOnline : decodedImage
        
        images = [UIImage()]
    }
    
    public func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(origin, forKey: .origin)
        try container.encode(imgUrl, forKey: .reference_image_id)
        try container.encode(lifeSpan, forKey: .life_span)
        try container.encode(temperament, forKey: .temperament)
        try container.encode(description, forKey: .description)
        try container.encode(favorite, forKey: .is_favorite)
        if let jpegData = image.jpegData(compressionQuality: 1.0) {
            try container.encode(jpegData, forKey: .savedImg)
        }
    }
}
