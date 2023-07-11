//
//  Errors.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 04/07/2023.
//

import Foundation

enum AppError: Error{
    case invalidUrl
    case invalidResponse
    case invalidJsonData
}
