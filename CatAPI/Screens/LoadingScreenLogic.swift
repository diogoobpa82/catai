//
//  LoadingScreenLogic.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 07/07/2023.
//

import UIKit

extension LoadingScreen{
    func checkInternet(completion: () -> Void){
        NetworkChecker.shared.startMonitoring()
        completion()
    }
    
    func rmvFav(){
        for breed in catBreeds{
            breed.favorite = false
        }
    }
    
    func getBreeds(){
        rmvFav()
        apiCalls.readArrayToFile(filename: "fav.txt")
        
        Task.init {
            do {
                catBreeds = try await isConnected ? apiCalls.getBreeds() : apiCalls.read(filename: "json1.json")!
                if isConnected {
                    getBreedImages()
                }
                else
                {
                    goToMenu()
                }
            } catch {
                // .. handle error
            }
        }
    }
    
    func getBreedImages(){
        
        var count = 0
        for breed in catBreeds{
            Task.init {
                do {
                    
                    let breedImg = try await apiCalls.getImageFromId(id: breed.imgUrl)
                    breed.image = breedImg.image
                    count += 1
                    
                    if count == catBreeds.count {
                        saveToFile()
                    }
                } catch {
                    count += 1
                    
                    if count == catBreeds.count {
                        saveToFile()
                    }
                }
            }
        }
    }
    
    func saveToFile(){
        setFav()
        apiCalls.write(array: catBreeds, filename: "json1.json")
        goToMenu()
    }
    
    func goToMenu(){
        setFav()
        stt.text = ""
        let vc = LaunchScreen()
        mainNavigationController?.pushViewController(vc, animated: true)
    }
    
    func setFav(){
        for breed in catBreeds {
            let filtered = favCatBreeds.first(where: {$0 == breed.id})
            breed.favorite = ((filtered?.isEmpty) != nil)
        }
    }
    
}
