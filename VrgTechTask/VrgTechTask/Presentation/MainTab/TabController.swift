//
//  TabController.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 30.03.2024.
//

import UIKit

class TabController: UITabBarController {

    var viewModel: TabViewModel
    
    init(viewModel: TabViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.barTintColor = .white
    }
    
    private func setupTabs() {
        let mostEmailedVM = MostEmailedViewModel()
        let mostSharedVM = MostSharedViewModel()
        let mostViewedVM = MostViewedViewModel()
        let favouriteVM = FavouriteArticlesViewModel()
        
        let mostEmailed = self.createNav(with: "Most Emailed", and: UIImage(systemName: "mail"), vc: MostEmailedView(viewModel: mostEmailedVM))
        let mostShared = self.createNav(with: "Most Shared", and: UIImage(systemName: "arrowshape.turn.up.right"), vc: MostSharedView(viewModel: mostSharedVM))
        let mostViewed = self.createNav(with: "Most Viewed", and: UIImage(systemName: "eye"), vc: MostViewedView(viewModel: mostViewedVM))
        let favouritesArticles = self.createNav(with: "Favourites", and: UIImage(systemName: "star.fill"), vc: FavouriteArticlesView(viewModel: favouriteVM))
        self.setViewControllers([mostEmailed, mostShared, mostViewed, favouritesArticles], animated: true)
    }

    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
    
}
