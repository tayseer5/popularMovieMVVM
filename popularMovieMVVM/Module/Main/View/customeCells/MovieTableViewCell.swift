//
//  MovieTableViewCell.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 01/14/22.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindData(_ articleModel: Movie) {
        ImageLoader().loadImage(with: articleModel.poster_path, image: movieImageView)
        movieName.text = articleModel.title ?? ""
    }
    @IBAction func changeFavouriteState(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
