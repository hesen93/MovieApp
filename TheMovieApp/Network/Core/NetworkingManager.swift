//
//  NetworkingManager.swift
//  NetworkingURLSession
//
//  Created by ferid on 29.01.25.
//

import Foundation
import Alamofire


class NetworkManager {

    func request<T: Codable>(path: String,
                              model: T.Type,
                              method:HTTPMethod = .get,
                              params:Parameters? = nil,
                              encodingType: EncodingType = .url,
                              //header:HTTPHeaders? = nil,
                              completion: @escaping((T?, String?) -> Void)) {
        AF.request(path,
                   method: method,
                   parameters: params,
                   encoding: encodingType == .url ? URLEncoding.default : JSONEncoding.default,
                   headers: NetworkHelper.shared.header).responseDecodable(of: model.self) {response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func request<T: Codable>(path: String,
                             model: T.Type,
                             method:HTTPMethod = .get,
                             params:Parameters? = nil,
                             encodingType: EncodingType = .url) async throws -> T?
    {
        return await withCheckedContinuation { continuation in
            AF.request(path,
                       method: method,
                       parameters: params,
                       encoding: encodingType == .url ? URLEncoding.default : JSONEncoding.default,
                       headers: NetworkHelper.shared.header).responseDecodable(of: model.self) {response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                //case .failure(let error):
                default: break
                }
            }
        }
        
    }
}

func mostFrequentElement(_ arr: [Int]) -> Int? {
    return arr.reduce(into: [:]) { counts, num in counts[num, default: 0] += 1 }
        .max { $0.value < $1.value }?.key
}
