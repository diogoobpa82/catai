//
//  Constants.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 04/07/2023.
//

import UIKit

let api_key = "live_hDAcds7rS0WgJ4QXtaMn6k4Cvl8QJJWwk3OlJprhUQ9f5Jp7drJJM62MVGDMH89H"
let urlBreeds = "https://api.thecatapi.com/v1/breeds"
let urlImg = "https://api.thecatapi.com/v1/images/"
let apiCalls = ApiCalls()
var mainNavigationController:UINavigationController!
var isConnected = false
var catBreeds:[CatBreed] = []
var favCatBreeds:[String] = []
