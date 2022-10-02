//
//  NetworkError.swift
//  baseswiftui
//
//  Created by Hai Dev on 02/10/2022.
//

import Foundation
import Alamofire

struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}
