//
//  ArticleDetailsViewModel.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 01/14/22.
//

import Foundation
class  ArticleDetailsViewModel: NSObject {
    // MARK: Varibles
    var article :Movie
    init(article: Movie) {
            self.article = article
            super.init()
    }
    
}
