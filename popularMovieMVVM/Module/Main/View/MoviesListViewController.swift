//
//  MoviesListViewController.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 01/14/22.
//

import UIKit

class MoviesListViewController: UIViewController {
    // MARK: IbOutLet
    @IBOutlet weak var articleListTableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    // MARK: varibles
    private var moviesListViewModel: MoviesListViewModel?
    private let refreshControl = UIRefreshControl()

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustTableView()
        callToViewModelForUIUpdate()
    }
    
    // MARK: UI Handling
    private func adjustTableView() {
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
        let articleTableViewCell = UINib(nibName: "ArticleTableViewCell",
                                  bundle: nil)
        articleListTableView.register(articleTableViewCell , forCellReuseIdentifier: "articleCell")
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        articleListTableView.addSubview(refreshControl)

    }
    // MARK: Helping Function
    //this function from init view model and add callBack function logic from binding btween view and view model which will happend when api response come from webserice
    private func callToViewModelForUIUpdate(){
        self.moviesListViewModel = MoviesListViewModel()
        self.moviesListViewModel?.bindMoviesListViewModelToController = {
            self.updateDataSource()
            return self
        }
    }
    // this function for notify data source that there was change in data 
    private func updateDataSource(){
        if moviesListViewModel?.articlesArray?.count ?? 0 > 0{
            articleListTableView.reloadData()
        } else {
            noDataView.isHidden = false
        }
    }
    @objc func pullToRefresh(_ sender: AnyObject) {
        moviesListViewModel?.reloadData()
        self.refreshControl.endRefreshing()
    }
}

// MARK: extention for TableViewDelegate
extension MoviesListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
}
// MARK: extention for TableviewDataSource
extension MoviesListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesListViewModel?.articlesArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleTableViewCell
        if let articleArray = moviesListViewModel?.articlesArray {
            cell?.bindData(articleArray[indexPath.row])
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moviesListViewModel?.selectArticle(at: indexPath.row)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (moviesListViewModel?.articlesArray?.count ?? 0) - 4) {
            moviesListViewModel?.getNextPage()
            
        }
    }
}

extension MoviesListViewController: viewBindDelegate {
    func pushToView(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
