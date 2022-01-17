//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Tayseer Anwar on 01/17/22.
//

import UIKit
import Kingfisher

class DetailCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieRuntimeLabel: UILabel!
    @IBOutlet weak var moviePopularityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setView(name: String?, posterPath: String?, description: String?, rating: Double?, popularity: Double?) {
        movieNameLabel.text = name
        movieDescriptionLabel.text = description
        ImageLoader().loadImage(with: posterPath, image: movieImageView)
        
        if let rating = rating, let popularity = popularity {
            moviePopularityLabel.text = String(popularity)
            movieRatingLabel.text = String(rating)
        }
    }
}
