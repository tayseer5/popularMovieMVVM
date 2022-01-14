//
//  ArticleTableViewCell.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 01/14/22.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var artcileData: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindData(_ articleModel: Movie) {
        ImageLoader().loadImage(with: articleModel.poster_path, image: articleImageView)
        artcileData.text = articleModel.title ?? ""
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
