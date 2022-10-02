//
//  Extentions.swift
//  baseswiftui
//
//  Created by Hai Dev on 02/10/2022.
//

import Foundation
import Alamofire

struct APIError: Error, Decodable {
    let message: String
    let code: String
    let args: [String]
}

final class TwoDecodableResponseSerializer<T: Decodable>: ResponseSerializer {
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    private lazy var successSerializer = DecodableResponseSerializer<T>(decoder: decoder)
    private lazy var errorSerializer = DecodableResponseSerializer<APIError>(decoder: decoder)

    public func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> Result<T, APIError> {

        guard error == nil else { return .failure(APIError(message: "Unknown error", code: "unknown", args: [])) }

        guard let response = response else { return .failure(APIError(message: "Empty response", code: "empty_response", args: [])) }

        do {
            if response.statusCode < 200 || response.statusCode >= 300 {
                let result = try errorSerializer.serialize(request: request, response: response, data: data, error: nil)
                return .failure(result)
            } else {
                let result = try successSerializer.serialize(request: request, response: response, data: data, error: nil)
                return .success(result)
            }
        } catch(let err) {
            return .failure(APIError(message: "Could not serialize body", code: "unserializable_body", args: [String(data: data!, encoding: .utf8)!, err.localizedDescription]))
        }

    }

}

extension DataRequest {
    @discardableResult func responseTwoDecodable<T: Decodable>(queue: DispatchQueue = DispatchQueue.global(qos: .userInitiated), of t: T.Type, completionHandler: @escaping (Result<T, APIError>) -> Void) -> Self {
        return response(queue: .main, responseSerializer: TwoDecodableResponseSerializer<T>()) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result)
            case .failure(let error):
                completionHandler(.failure(APIError(message: "Other error", code: "other", args: [error.localizedDescription])))
            }
        }
    }
}
