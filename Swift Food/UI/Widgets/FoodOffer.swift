//
//  FoodOffer.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 18/10/2020.
//

import Foundation
import UIKit
import Kingfisher

final class FoodOffer: UITableViewCell {
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var portionLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    var buyListener: ((Food) -> Void)?
    var food: Food?
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        let path = UIBezierPath(roundedRect: self.foodImage.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 24.0, height: 24.0))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.foodImage.layer.mask = mask
    }
    
    private func setupUI() {
        self.clipsToBounds = true
        self.buyButton.layer.cornerRadius = self.buyButton.frame.height / 2.0
        self.buyButton.clipsToBounds = true
        self.foodImage.contentMode = .scaleAspectFill
    }
    
    func setup(_ food: Food) {
        self.food = food
        self.foodImage.kf.setImage(with: URL(string: food.photoURL)!)
        self.nameLabel.text = food.name
        self.descriptionLabel.text = food.description
        self.portionLabel.text = food.portion
        self.buyButton.setTitle("\(food.price) usd", for: .normal)
        self.buyButton.setTitle("added +1", for: .highlighted)
        self.buyButton.setBackgroundImage(UIImage.from(color: UIColor.green), for: .highlighted)
        self.buyButton.addTarget(self, action: #selector(onTapBuy(_:)), for: .touchUpInside)
    }
    
    @objc func onTapBuy(_ sender: Any) {
        if let buyListener = self.buyListener {
            buyListener(food!)
        }
    }
}
