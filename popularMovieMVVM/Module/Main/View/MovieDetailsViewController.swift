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
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.barTintColor = .black
        detailsTableView.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "MoiveCell")
        detailsTableView.dataSource = self
    }
    
    private func configureUI() {
//        activityIndicator.stopAnimating()
//        activityIndicator.isHidden = true
       // self.detailsTableView.reloadData()
        //detailsTableView.isHidden = false
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
