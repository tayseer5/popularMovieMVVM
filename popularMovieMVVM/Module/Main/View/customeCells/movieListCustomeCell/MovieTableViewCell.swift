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
    private var movieTableViewCellViewModel: MovieTableViewCellViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindData(_ movieTableViewCellViewModel: MovieTableViewCellViewModel) {
        self.movieTableViewCellViewModel = movieTableViewCellViewModel
        ImageLoader().loadImage(with: movieTableViewCellViewModel.movie.poster_path, image: movieImageView)
        movieName.text = movieTableViewCellViewModel.movie.title ?? ""
        let imageName = movieTableViewCellViewModel.movie.isFavourite ? "heart.fill" :"heart"
        favouriteButton.setBackgroundImage( UIImage(systemName: imageName), for: UIControl.State.normal)
    }
    @IBAction func changeFavouriteState(_ sender: Any) {
        let imageName = movieTableViewCellViewModel?.changeFavouriteState() ?? false ? "heart.fill" :"heart"
        
        favouriteButton.setBackgroundImage( UIImage(systemName: imageName), for: UIControl.State.normal)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
