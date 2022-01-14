//
//  ArticleDetailsViewController.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 01/14/22.
//

import UIKit

class ArticleDetailsViewController: UIViewController {
    // MARK: IbOutLet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    // MARK: varibles
    var articleDetailsViewModel: ArticleDetailsViewModel?
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayData()
    }
    // MARK: Helping Function
    private func displayData () {
        titleLabel.text = "Title: \(articleDetailsViewModel?.article.title ?? "UnDefine")"
        ImageLoader().loadImage(with: articleDetailsViewModel?.article.poster_path, image: articleImageView)
    }
}
