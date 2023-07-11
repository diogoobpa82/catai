//
//  ApiCalls.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 04/07/2023.
//

import UIKit

public class ApiCalls
{
    public func getBreeds() async throws -> [CatBreed] {
        
        guard let url =  URL(string: urlBreeds) else {throw AppError.invalidUrl }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw AppError.invalidResponse}
        
        do {
            let decoder =  JSONDecoder()
            return try decoder.decode([CatBreed].self, from: data)
        } catch {
            throw AppError.invalidJsonData
        }
    }
    
    public func getImageFromId(id:String) async throws -> BreedImage {
        let finalUrl = urlImg + id
        guard let url =  URL(string: finalUrl) else {throw AppError.invalidUrl }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw AppError.invalidResponse
        }
        
        do {
            let decoder =  JSONDecoder()
            return try decoder.decode(BreedImage.self, from: data)
        } catch {
            throw AppError.invalidJsonData
        }
    }
    
    public func write<T: Codable>(array: [T], filename: String) {
        var file: URL
            do {
                file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    .appendingPathComponent(filename)
            } catch {
                fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
            }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            try encoder.encode(array).write(to: file)
        } catch {
            print("Couldn’t save new entry to \(filename), \(error.localizedDescription)")
        }
    }
    
    public func read<T: Codable>(filename: String) -> T? {
        
        var file: URL
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    .appendingPathComponent(filename)
        } catch {
            fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
        }
        
        var data: Data?
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            print("Couldn't load \(filename) from main bundle or document directory :\n\(error)")
        }

        guard data != nil else { return [] as! T }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data!)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    public func saveArrayToFile(array:[String],filename:String){
        var file: URL
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    .appendingPathComponent(filename)
        } catch {
            fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
        }

        let joinedImagesArray = array.joined(separator: "\n") /// separated by newline
        do {
            try joinedImagesArray.write(toFile: file.path, atomically: true, encoding: .utf8)
            print(file)
        } catch {
            print(error)
        }
    }
    
    public func readArrayToFile(filename:String){
        var file: URL
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    .appendingPathComponent(filename)
        } catch {
            fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
        }
        
        var data: String = ""
        
        do {
            data = try String(contentsOf: file)
            let text: [String] = data.components(separatedBy: "\n")
            favCatBreeds = text
        } catch {
            print("Couldn't load \(filename) from main bundle or document directory :\n\(error)")
        }
    }
}
