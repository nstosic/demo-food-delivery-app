//
//  FoodBanner.swift
//  Swift Food
//
//  Created by Nemanja Stosic on 18/10/2020.
//

import Foundation
import UIKit
import Kingfisher

final class FoodBanner: UIView {
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        let bundle: Bundle = Bundle(for: type(of: self))
        let nib: UINib = UINib(nibName: String(describing: FoodBanner.self), bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: bounds.height)
            view.translatesAutoresizingMaskIntoConstraints = true
            addSubview(view)
            layoutIfNeeded()
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.circleView.layer.cornerRadius = self.circleView.frame.width / 2.0
    }
    
    func setup(_ offer: FoodPromo) {
        self.backgroundImageView.kf.setImage(with: URL(string: "https://donesi.com/cdn-cgi/image/h=1080,f=auto,q=100/site-assets/img/bg/hero/home/Desktop/DN-afternoon-2.jpg")!)
        self.backgroundImageView.contentMode = .scaleAspectFit
        self.titleLabel.text = offer.title
        self.subtitleLabel.text = offer.subtitle
    }
}
