//
//  NetworkableProtocol.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 01/14/22.
//

import Foundation
import Moya

/// Network Protocol That contain Provider and Header of fetch method
protocol Networkable {
    var provider: MoyaProvider<MoviesAPI> { get }

    func getMostPopularNYArticles(page: Int, completion: @escaping (Result<MoviesListResponse, Error>) -> ())
   
}
