//
//  Service.swift
//  baseswiftui
//
//  Created by Hai Dev on 02/10/2022.
//

import Foundation
import Combine
import Alamofire

protocol ServiceProtocol {
    func fetchChats() -> AnyPublisher<DataResponse<Message, NetworkError>, Never>?
    func login(parameters: Parameters) -> AnyPublisher<DataResponse<LoginModel, NetworkError>, Never>
}


class Service {
    static let shared: ServiceProtocol = Service()
    private init() { }
}

extension Service: ServiceProtocol {
    func fetchChats() -> AnyPublisher<DataResponse<Message, NetworkError>, Never>? {
        return getCall(url: URL(string: "http://127.0.0.1:3000/healthcheck")!)
    }
    
    func login(parameters: Parameters) -> AnyPublisher<DataResponse<LoginModel, NetworkError>, Never> {
        let url = URL(string: "http://127.0.0.1:3000/api/sessions")!
        return postCall(url: url, parameters: parameters)
    }
    
    func postCall<T>(url: URL, parameters: Parameters) -> AnyPublisher<DataResponse<T, NetworkError>, Never> where T: Codable {
        return AF.request(url,method: .post, parameters: parameters)
            .validate()
            .publishDecodable(type: T.self)
            .map { response in
                response.mapError { error in
                    print("URL ERROR: \(String(describing: response.response?.statusCode))")
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getCall<T>(url: URL) -> AnyPublisher<DataResponse<T, NetworkError>, Never>? where T: Codable {
        return AF.request(url,method: .get)
            .validate()
            .publishDecodable(type: T.self)
            .map { response in
                response.mapError { error in
//                    if response.response?.statusCode == 404 {
//                        print("404")
//                    }
//                    guard let data = response.data else {
//                        let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
//                        return NetworkError(initialError: error, backendError: backendError)
//                    }
//                               do {
//                                   let json = try JSONDecoder().decode(T.self, from: data)
////                                   let message = json["message"]
//                                   debugPrint("message ERROR: \(json)")
//
//                               } catch {
//                                   debugPrint("CATCH ERROR: \(error)")
//                               }
                    
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func handleError() {
        
    }
}
