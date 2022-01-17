//
//  ImageLoader.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 1/14/22.
//

import Foundation
import Kingfisher
import UIKit

struct ImageLoader {
    func loadImage(with endpoint: String?, image: UIImageView) {
        if let endpoint = endpoint {
            let url = URL(string: Constant.IMAGE_URL + endpoint)
            image.kf.setImage(
                with: url,
                placeholder: UIImage(named: "NYTIcon"),
                options: [
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        }
    }
}

