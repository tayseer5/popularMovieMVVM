//
//  MovieTableViewCellViewModel.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 1/18/22.
//

import Foundation

import Foundation

class  MovieTableViewCellViewModel: NSObject {
    // MARK: Varibles
    var movie :Movie
    var changeDataInArray:ChangeDataInArray
    var index: Int
    init(movie: Movie,changeDataInArray:ChangeDataInArray, index: Int ) {
        self.movie = movie
        self.changeDataInArray = changeDataInArray
        self.index = index
        super.init()
    }
    
    func changeFavouriteState() -> Bool{
        if let modelId = movie.id {
            let defaults = UserDefaults.standard
            var favouriteIds = defaults.array(forKey: "FavouriteId") as? [Int] ?? []
            if movie.isFavourite {
                favouriteIds.remove(object: modelId)
                changeDataInArray.changeFavouriteState(index: index, state: false)
                defaults.setValue(favouriteIds, forKey: "FavouriteId")
                return false
            } else {
                favouriteIds.append(modelId)
                changeDataInArray.changeFavouriteState(index: index, state: true)
                defaults.setValue(favouriteIds, forKey: "FavouriteId")
                return true
            }
            
        }
        return false
        
    }
    
}
