//
//  MovieDetailsViewModel.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 01/14/22.
//

import Foundation

class  MovieDetailsViewModel: NSObject {
    // MARK: Varibles
    var movie :Movie
    init(movie: Movie) {
            self.movie = movie
            super.init()
    }
    
    func changeFavouriteState(){
        
    }
    
}
