//
//  BrowseView.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 18/10/2020.
//

import Foundation
import UIKit
import Resolver

class BrowseView: BaseView {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var categoryTabs: UIStackView!
    @IBOutlet weak var shoppingCartButton: UIButton!
    
    @Injected var presenter: BrowsePresenter
    var categories: [FoodCategory] = [FoodCategory]()
    var food: [[Food]] = [[Food]]()
    var displayedIndex = -1
    var onScrollListener: ((CGFloat) -> Void)?
    var onItemBuyListener: ((Food) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryTabs.axis = .horizontal
        self.categoryTabs.alignment = .center
        self.categoryTabs.distribution = .fillEqually
        self.scrollView.delegate = self
        self.scrollView.contentInsetAdjustmentBehavior = .never
        self.shoppingCartButton.layer.cornerRadius = self.shoppingCartButton.frame.width / 2.0
        self.shoppingCartButton.addTarget(self, action: #selector(onShoppingCartTapped(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.refreshCategories(onSuccess: { [unowned self] data in
            self.categories = data
            self.setupTabContents()
        }, onFailure: { error in
            print("An error has occurred: \(error)")
        })
        Cart.sharedInstance.addListener { cart in
            let count = cart.count
            if self.shoppingCartButton.subviews.last is UILabel {
                self.shoppingCartButton.subviews.last?.removeFromSuperview()
            }
            if count > 0 {
                let label = UILabel(frame: CGRect(x: self.shoppingCartButton.frame.width - 20.0, y: 4.0, width: 16.0, height: 16.0))
                label.clipsToBounds = true
                label.layer.cornerRadius = label.font.pointSize * 1.2 / 2
                label.backgroundColor = UIColor.green
                label.textColor = UIColor.white
                label.text = " \(count) "
                self.shoppingCartButton.addSubview(label)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Cart.sharedInstance.removeListeners()
        super.viewWillDisappear(animated)
    }
    
    private func setupTabContents() {
        for child in self.categoryTabs.subviews {
            child.removeFromSuperview()
        }
        for child in self.scrollView.subviews {
            child.removeFromSuperview()
        }
        for i in 0...self.categories.count - 1 {
            let tabButton = UIButton()
            tabButton.tag = i
            tabButton.setTitle(self.categories[i].name, for: .normal)
            tabButton.setTitleColor(UIColor.systemGray, for: .normal)
            tabButton.titleLabel?.font = UIFont.systemFont(ofSize: 24.0)
            tabButton.addTarget(self, action: #selector(onTabSelected(_:)), for: .touchUpInside)
            self.categoryTabs.addArrangedSubview(tabButton)
            let tableView = UITableView(frame: CGRect(x: UIScreen.main.bounds.width * CGFloat(i), y: 0.0, width: UIScreen.main.bounds.width, height: scrollView.frame.height))
            tableView.register(UINib(nibName: String(describing: FoodOffer.self), bundle: nil), forCellReuseIdentifier: String(describing: FoodOffer.self))
            tableView.tag = i
            tableView.separatorStyle = .none
            tableView.dataSource = self
            tableView.delegate = self
            self.scrollView.addSubview(tableView)
        }
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(self.categories.count), height: scrollView.frame.height)
        onTabChanged(0)
    }
    
    @objc func onTabSelected(_ sender: Any) {
        guard let tabButton = sender as? UIButton else { return }
        let index = tabButton.tag
        if displayedIndex != index {
            onTabChanged(index)
        }
    }
    
    @objc func onShoppingCartTapped(_ sender: Any) {
        self.presenter.goToCartView()
    }
    
    func onTabChanged(_ index: Int) {
        if displayedIndex != -1 {
            let tabButton = categoryTabs.subviews[displayedIndex] as! UIButton
            tabButton.titleLabel?.font = UIFont.systemFont(ofSize: 24.0)
            tabButton.setTitleColor(UIColor.systemGray, for: .normal)
        }
        displayedIndex = index
        let selectedTabButton = categoryTabs.subviews[displayedIndex] as! UIButton
        selectedTabButton.titleLabel?.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        selectedTabButton.setTitleColor(UIColor.systemBlue, for: .normal)
        presenter.refreshFood(categories[index], onSuccess: { [unowned self] data in
            if self.food.count > index {
                self.food[index] = data
            } else {
                self.food.append(data)
            }
            (self.scrollView.subviews[displayedIndex] as! UITableView).reloadData()
        }, onFailure: { error in
            print("An error has occurred: \(error)")
        })
        scrollView.scrollRectToVisible(CGRect(x: CGFloat(displayedIndex) * scrollView.frame.width, y: scrollView.contentOffset.y, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
    }
}

extension BrowseView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard !(scrollView is UITableView) else { return }
        let index = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        if displayedIndex != index {
            onTabChanged(index)
        }
    }
}

extension BrowseView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let index = tableView.tag
        if self.food.count > index {
            return self.food[index].count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = tableView.tag
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodOffer.self)) as! FoodOffer
        cell.setup(food[index][indexPath.row])
        cell.buyListener = onItemBuyListener
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 424.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 424.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView is UITableView else { return }
        if let onScrollListener = self.onScrollListener {
            onScrollListener(scrollView.contentOffset.y)
        }
    }
}
