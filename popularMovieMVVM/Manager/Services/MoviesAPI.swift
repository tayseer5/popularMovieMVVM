//
//  MoviesAPI.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 01/14/22.
//

import Foundation
import Moya


//enums for apis used in app
enum MoviesAPI {
    case mostPopularMovies(page:Int)
}

// This is the variables used to create the api request
extension MoviesAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Constant.baseURL) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .mostPopularMovies:
            return Constant.mostPopular
        }
    }
    
    
    var method: Moya.Method {
            return .get
    }
    
    var sampleData: Data {
            return Data()
    }
    
    var task: Task {
        switch self {
        case .mostPopularMovies(let page):
            return .requestParameters(parameters: ["api_key": Constant.apiKey,"language":"en-US","page":page], encoding: URLEncoding.queryString)
            }
    }
    var headers: [String : String]? {
            return nil
        }
    
}
