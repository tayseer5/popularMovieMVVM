//
//  Extentions.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 1/18/22.
//

import Foundation

extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }

}
