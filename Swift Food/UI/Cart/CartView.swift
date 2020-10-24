//
//  CartView.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 24/10/2020.
//

import Foundation
import UIKit

class CartView: BaseView {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: CartItem.self), bundle: nil), forCellReuseIdentifier: String(describing: CartItem.self))
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Cart.sharedInstance.addListener { [unowned self] (cart) in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Cart.sharedInstance.removeListeners()
        super.viewWillDisappear(animated)
    }
}

extension CartView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.sharedInstance.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < Cart.sharedInstance.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CartItem.self)) as! CartItem
            cell.setup(Cart.sharedInstance.getItem(indexPath.row))
            cell.tag = indexPath.row
            return cell
        }
        let cell = UITableViewCell(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 40.0))
        if Cart.sharedInstance.count == 0 {
            cell.textLabel?.text = "You cart is empty."
        } else {
            cell.textLabel?.text = "Value: "
            cell.textLabel?.sizeToFit()
            let totalLabel = UILabel()
            totalLabel.frame = CGRect(x: cell.textLabel!.frame.width + 16.0, y: 0.0, width: 256.0, height: 40.0)
            totalLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)
            totalLabel.text = "\(Cart.sharedInstance.totalPrice()) usd"
            totalLabel.sizeToFit()
            cell.addSubview(totalLabel)
        }
        return cell
    }
    
    
}
