//
//  popularMovieMVVMTests.swift
//  popularMovieMVVMTests
//
//  Created by Tayseer Anwar on 1/17/22.
//

import XCTest
import Foundation
@testable import popularMovieMVVM

class YourViewControllerTest: XCTestCase {
    
    func testParsingMovie() throws {
        let bundle = Bundle(for: YourViewControllerTest.self)
        let url =  bundle.url(forResource: "movie", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let movie = try JSONDecoder().decode(Movie.self, from: data)
        
        XCTAssertEqual(movie.title , "Sing 2")
        XCTAssertEqual(movie.vote_average , 8.2)
        XCTAssertEqual(movie.release_date , "2021-12-01")
        XCTAssertEqual(movie.id , 438695)
    }
}
