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
    @IBOutlet weak var reloadButtonFromNoDataView: UIButton!
    @IBOutlet weak var noDataLabel: UILabel!
    
    // MARK: varibles
    private var moviesListViewModel: MoviesListViewModel?
    private let refreshControl = UIRefreshControl()

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustTableView()
        prepareUI()
        callToViewModelForUIUpdate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if self.moviesListViewModel?.changeDataInArray {
//            self.reload()
//        }
    }
    // MARK: UI Handling
    private func adjustTableView() {
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
        let movieTableViewCell = UINib(nibName: "MovieTableViewCell",
                                  bundle: nil)
        articleListTableView.register(movieTableViewCell , forCellReuseIdentifier: "movieCell")
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        articleListTableView.addSubview(refreshControl)
    }
    private func prepareUI () {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .red
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filterIcon.png"), style:.plain, target: self, action: #selector(switchList(_:)))
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
        if moviesListViewModel?.MoviesArray?.count ?? 0 > 0{
            noDataView.isHidden = true
            self.reload()
        } else {
            noDataView.isHidden = false
            if moviesListViewModel?.isDisplayFavList ?? false {
                reloadButtonFromNoDataView.isHidden = true
                noDataLabel.text = "No Favourite Movies"
            } else {
                reloadButtonFromNoDataView.isHidden = false
                noDataLabel.text = "No Movies"
            }
        }
    }
    @objc func pullToRefresh(_ sender: AnyObject) {
        moviesListViewModel?.reloadData()
        self.refreshControl.endRefreshing()
    }
    @objc func switchList(_ sender: AnyObject) {
        moviesListViewModel?.switchList()
    }
    @IBAction func tryToReGetData(_ sender: Any) {
        moviesListViewModel?.reloadData()
    }
}

// MARK: extention for TableViewDelegate
extension MoviesListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
// MARK: extention for TableviewDataSource
extension MoviesListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesListViewModel?.MoviesArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell
        if let moviesListViewModel = moviesListViewModel, let moviesArray =  moviesListViewModel.MoviesArray {
            let  movieTableViewCellViewModel = MovieTableViewCellViewModel(movie: moviesArray[indexPath.row], changeDataInArray: moviesListViewModel, index: indexPath.row)
            cell?.bindData(movieTableViewCellViewModel)
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moviesListViewModel?.selectMovie(at: indexPath.row)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (moviesListViewModel?.MoviesArray?.count ?? 0) - 4) && (moviesListViewModel?.isPaginationEnabled ?? true) {
            moviesListViewModel?.getNextPage()
        }
    }
}

extension MoviesListViewController: viewBindDelegate {
    func pushToView(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func reload(){
        articleListTableView.reloadData()
    }

}
