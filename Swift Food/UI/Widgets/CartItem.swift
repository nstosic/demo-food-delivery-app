//
//  CartItem.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 24/10/2020.
//

import Foundation
import UIKit

class CartItem: UITableViewCell {
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16.0, left: 8.0, bottom: 16.0, right: 8.0))
        self.deleteButton.layer.cornerRadius = self.deleteButton.frame.width / 2.0
        self.deleteButton.addTarget(self, action: #selector(onDeleteTapped(_:)), for: .touchUpInside)
    }
    
    func setup(_ food: Food) {
        self.foodImageView.kf.setImage(with: URL(string: food.photoURL)!)
        self.foodName.text = food.name
        self.foodPrice.text = "\(food.price)"
    }
    
    @objc func onDeleteTapped(_ sender: Any) {
        Cart.sharedInstance.removeFromCart(self.tag)
    }
}
