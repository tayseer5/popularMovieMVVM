//
//  MoviesListResponse.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 01/14/22.
//

import Foundation
import Realm
import RealmSwift

// MARK: - ResponseMOdel
struct MoviesListResponse: Codable {
    let page : Int?
    let results : [Movie]?
    let total_pages : Int?
    let total_results : Int?

enum CodingKeys: String, CodingKey {

    case page
    case results
    case total_pages
    case total_results
    
}
}

// MARK: - Result
class Movie: Object, Codable {
    @Persisted var adult : Bool?
    @Persisted var backdrop_path : String?
//    @Persisted var genre_ids : [Int]?
    @Persisted(primaryKey: true) var id : Int?
    @Persisted var original_language : String?
    @Persisted var original_title : String?
    @Persisted var overview : String?
    @Persisted var popularity : Double?
    @Persisted var poster_path : String?
    @Persisted var release_date : String?
    @Persisted var title : String?
    @Persisted var video : Bool?
    @Persisted var vote_average : Double?
    @Persisted var vote_count : Int?
   
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdrop_path = "backdrop_path"
//        case genre_ids = "genre_ids"
        case id = "id"
        case original_language = "original_language"
        case original_title = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case poster_path = "poster_path"
        case release_date = "release_date"
        case title = "title"
        case video = "video"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
    }
}

