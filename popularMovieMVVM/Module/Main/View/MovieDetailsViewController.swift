//
//  MovieDetailsViewController.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 01/14/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    // MARK: IbOutLet
    
    @IBOutlet weak var detailsTableView: UITableView!
    // @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Properties
    var movieDetailsViewModel: MovieDetailsViewModel?
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()

    }
    
    // MARK: - Helpers
    private func prepareUI() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .red
        let imageName = movieDetailsViewModel?.movie.isFavourite ?? false ? "heart.fill" :"heart"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: imageName), style:.plain, target: self, action: #selector(changeFavouriteState(_:)))
        detailsTableView.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "MoiveCell")
        detailsTableView.dataSource = self
    }
    @objc func changeFavouriteState(_ sender: AnyObject) {
        let imageName =  movieDetailsViewModel?.changeFavouriteState() ?? false ? "heart.fill" :"heart"
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
    }
    
    
}
// MARK: - UITableViewDataSource
extension MovieDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = detailsTableView.dequeueReusableCell(withIdentifier: "MoiveCell", for: indexPath) as! DetailCell
        cell.setView(name: movieDetailsViewModel?.movie.title,
                             posterPath: movieDetailsViewModel?.movie.poster_path,
                             description: movieDetailsViewModel?.movie.overview,
                             rating: movieDetailsViewModel?.movie.vote_average,
                             popularity: movieDetailsViewModel?.movie.popularity)
            return cell
            
        
    }
}
