//
//  MockManager.swift
//  TheMovieApp
//
//  Created by ferid on 05.04.25.
//

import Foundation

enum MockError:Error {
    case fileNotFound
    case invalidData
}

class MockManager {
    
    func loadFile <T:Codable> (fileName: String, type:T.Type, completion: ((T?,String?) -> Void)) {
        guard let file = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            completion(nil,MockError.fileNotFound.localizedDescription)
            return
        }
        guard let data = try? Data(contentsOf: file) else {
            completion(nil,MockError.invalidData.localizedDescription)
            return
        }
        do {
            let model = try JSONDecoder().decode(type, from: data)
            completion(model,nil)
        } catch {
            completion(nil,error.localizedDescription)
        }
    }
}
