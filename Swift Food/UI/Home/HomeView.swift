//
//  HomeView.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 18/10/2020.
//

import Foundation
import UIKit
import Resolver

class HomeView: BaseView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var deliveryTypeLabel: UILabel!
    
    @Injected var presenter: HomePresenter
    var offers: [FoodPromo] = [FoodPromo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.scrollView.delegate = self
        self.contentViewHeight.constant = UIScreen.main.bounds.width
        self.restaurantLabel.text = "Kazarov"
        self.deliveryTypeLabel.text = "delivery"
        embedBrowseView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.loadOffers(onSuccess: { [unowned self] data in
            self.offers = data
            self.updateScrollViewContents()
        }, onFailure: { error in
            
        })
    }
    
    private func embedBrowseView() {
        let browseView = BrowseView()
        addChild(browseView)
        browseView.view.frame = CGRect(x: 0.0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
        view.addSubview(browseView.view)
        browseView.didMove(toParent: self)
        UIView.animate(withDuration: 0.5) { [unowned self] in
            browseView.view.frame.origin = CGPoint(x: 0.0, y: self.contentViewHeight.constant)
        }
        browseView.onItemBuyListener = { [unowned self] food in
            self.presenter.addToCart(food)
        }
        browseView.onScrollListener = { [unowned self] offset in
            if offset < UIScreen.main.bounds.width {
                self.contentViewHeight.constant = UIScreen.main.bounds.width - offset
            } else {
                self.contentViewHeight.constant = 0.0
            }
            guard let browseView = self.view.subviews.last else { return }
            browseView.frame.origin = CGPoint(x: 0.0, y: self.contentViewHeight.constant)
        }
    }
    
    private func updateScrollViewContents() {
        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
        }
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(offers.count), height: self.scrollView.frame.height)
        for i in 0...offers.count - 1 {
            let offerView = FoodBanner(frame: CGRect(x: CGFloat(i) * UIScreen.main.bounds.width, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
            offerView.setup(offers[i])
            self.scrollView.addSubview(offerView)
        }
    }
}

extension HomeView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.pageControl.currentPage = Int(pageNumber)
    }
}
