//
//  MoviesListViewModel.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 01/14/22..
//

import Foundation
import UIKit
protocol viewBindDelegate {
    func pushToView(viewController: UIViewController)
    func reload()
}
protocol ChangeDataInArray {
    func changeFavouriteState(index: Int,state:Bool)
}
/// view model for main screen will hides all asynchronous networking code, data preparation code for visual presentation, and code listening for Model changes.  
/// once view model receive response and prepare data it will notify view throught binding and binding function will return a confirmation for viewModelbinding  protocol
class  MoviesListViewModel: NSObject {
    // MARK: Varibles
    //this is object from networkManager
    private var apiService: NetworkManager?
    // this is the result of bind view with viewModel it's confirmation for viewBindDelegate Protocol
    private var viewBindDelegate: viewBindDelegate?
    // this is object of response model of api call for most popular movie
    // when object is init from api respponse the bind between ViewModel and View will done by calling callback function of bind which implemnted in view
    private(set) var MoviesArray : [Movie]? {
            didSet {
                if let bind = self.bindMoviesListViewModelToController {
                    viewBindDelegate = bind()
                }
            }
        }
    // this varible will be implemented in the view and this is the bind between viewModel and view
    var bindMoviesListViewModelToController : (() -> (viewBindDelegate?))?
    private var pageNumber = 1
    var isDisplayFavList = false
    var isPaginationEnabled = true
    
    // MARK: Init Function
    override init() {
        super.init()
        self.apiService = NetworkManager()
        getMostPopularMovies()
    }
    
    // MARK: Helping Functions
    // Api Call for Movieslist
    private func getMostPopularMovies() {
        self.apiService?.getMostPopularMovies(page: pageNumber) { result in
            switch result {
                    case .success(let response):
                        self.handlingResponse( data: response.results ?? [])
                        if self.pageNumber == response.total_pages {
                            self.isPaginationEnabled = false
                        }
                    case .failure(let error):
                        self.handlingResponse( data: [])
                        print(error.localizedDescription)
                    }
        }
    }
    
    private func handlingResponse(data:[Movie]) {
        if data.isEmpty && pageNumber == 1 {
            self.MoviesArray = WARealmManager.shared.getMovies()
        } else {
            if pageNumber == 1 {
                self.MoviesArray = data
            }else{
                self.MoviesArray?.append(contentsOf: data)
            }
            pageNumber += 1
            WARealmManager.shared.createMoviesTable(movieArray: self.MoviesArray ?? [])
        }
    }
    private func  getFavouriteList (){
        let arr = MoviesArray?.filter {
            $0.isFavourite == true
        }
        MoviesArray = arr
        self.viewBindDelegate?.reload()
    }
}
// MARK: View Event Notifer
extension MoviesListViewModel{
    // this function called from view to inform ViewModel that there was selected happend
    func selectMovie (at index: Int)  {
        if let movies = MoviesArray , movies.count > index {
            let moviewDetailsViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController
            let movieDetailsViewModel: MovieDetailsViewModel = MovieDetailsViewModel(movie: movies[index], changeDataInArray: self, index: index)
            moviewDetailsViewController?.movieDetailsViewModel = movieDetailsViewModel
            // after view model finish logic of get model after selection raw and init view mode and view of details screen it pass it to view to push it by calling delegate which view confirm 
            self.viewBindDelegate?.pushToView(viewController: moviewDetailsViewController ?? UIViewController())
        }
    }
    func getNextPage(){
        if !isDisplayFavList {
        self.getMostPopularMovies()
        }
    }
    func reloadData () {
        pageNumber = 1
        self.getMostPopularMovies()
        isDisplayFavList = false
    }
    func switchList(){
        if isDisplayFavList{
            isDisplayFavList = false
            isPaginationEnabled = true
            reloadData()
        } else {
            isDisplayFavList = true
            isPaginationEnabled = false
            getFavouriteList ()
        }
    }
}
extension MoviesListViewModel :ChangeDataInArray {
    func changeFavouriteState(index: Int, state:Bool) {
        if isDisplayFavList {
            MoviesArray?.remove(at: index)
        } else {
            MoviesArray?[index].isFavourite = state
        }
        self.viewBindDelegate?.reload()
        
        
    }
    
    
}
