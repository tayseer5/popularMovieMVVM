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
}

/// view model for main screen will hides all asynchronous networking code, data preparation code for visual presentation, and code listening for Model changes.  
/// once view model receive response and prepare data it will notify view throught binding and binding function will return a confirmation for viewModelbinding  protocol
class  MoviesListViewModel: NSObject {
    // MARK: Varibles
    //this is object from networkManager
    private var apiService: NetworkManager?
    // this is the result of bind view with viewModel it's confirmation for viewBindDelegate Protocol
    private var viewBindDelegate: viewBindDelegate?
    // this is object of response model of api call for most popular article
    // when object is init from api respponse the bind between ViewModel and View will done by calling callback function of bind which implemnted in view
    private(set) var articlesArray : [Movie]? {
            didSet {
                if let bind = self.bindMoviesListViewModelToController {
                    viewBindDelegate = bind()
                }
            }
        }
    // this varible will be implemented in the view and this is the bind between viewModel and view
    var bindMoviesListViewModelToController : (() -> (viewBindDelegate?))?
    private var pageNumber = 1
    
    // MARK: Init Function
    override init() {
        super.init()
        self.apiService = NetworkManager()
        getMostPopularArticle()
       
    }
    // MARK: Helping Functions
    // Api Call for article list
    private func getMostPopularArticle() {
        self.apiService?.getMostPopularNYArticles(page: pageNumber) { result in
            switch result {
                    case .success(let response):
                        //self.articlesArray = response.results
                        self.handlingResponse( data: response.results ?? [])
                    case .failure(let error):
                        self.handlingResponse( data: [])
                       // self.articlesArray = []
                        print(error.localizedDescription)
                    }
        }
    }
    private func handlingResponse(data:[Movie]) {
        if pageNumber == 1 {
            self.articlesArray = data
        }else{
            self.articlesArray?.append(contentsOf: data)
        }
        pageNumber += 1
    }
}
// MARK: View Event Notifer
extension MoviesListViewModel{
    // this function called from view to inform ViewModel that there was selected happend
    func selectArticle (at index: Int)  {
        if let articles = articlesArray , articles.count > index {
            let articleDetailsViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ArticleDetailsViewController") as? ArticleDetailsViewController
            let articleDetailsViewModel: ArticleDetailsViewModel = ArticleDetailsViewModel(article:articles[index])
            articleDetailsViewController?.articleDetailsViewModel = articleDetailsViewModel
            // after view model finish logic of get model after selection raw and init view mode and view of details screen it pass it to view to push it by calling delegate which view confirm 
            self.viewBindDelegate?.pushToView(viewController: articleDetailsViewController ?? UIViewController())
            
        }
    }
    func getNextPage(){
        self.getMostPopularArticle()
    }
    
}
