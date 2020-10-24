//
//  API.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 24/10/2020.
//

import Foundation
import Moya

enum APIRequest {
    case categories
    case food(_ category: FoodCategory)
}

extension APIRequest: TargetType {
    var baseURL: URL {
        return URL(string: "https://base.url/")!
    }
    
    var path: String {
        switch self {
        case .categories:
            return "categories"
        case .food(let category):
            return "categories/\(category.id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .categories, .food(_):
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .categories:
            return Data(base64Encoded: "")!
        case .food(_):
            return Data(base64Encoded: "{\"categoryId\":\"1\"}")!
        }
    }
    
    var task: Task {
        switch self {
        case .categories:
            return .requestPlain
        case .food(let category):
            return .requestParameters(parameters: ["categoryId" : category.id], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Authorization": "Bearer token",
            "Content-Type": "application/json"
        ]
    }
    
    
}

protocol API {
    
}
