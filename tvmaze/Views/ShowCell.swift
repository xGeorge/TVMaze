//
//  ShowCell.swift
//  tvmaze
//
//  Created by Jorge Armando Torres Perez on 17/01/21.
//

import UIKit

class ShowCell: UICollectionViewCell {

    static let cellIdentifier = "collectionCell"
    static let space: CGFloat = 8.0
    static let cellHeight: CGFloat = 250

    static var cellWidth: CGFloat {
        return UIScreen.widthOfSafeArea()/3 - 2 * space
    }

    let backgroundImage = UIImageView()
    let showName = UILabel()
    let channelName = UILabel()
    let container: UIStackView

    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        backgroundImage.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }()

    override init(frame: CGRect) {
        container = UIStackView(arrangedSubviews: [showName, channelName])
        super.init(frame: frame)

        contentView.addSubview(backgroundImage)

        showName.numberOfLines = 0
        showName.textAlignment = .center

        channelName.numberOfLines = 0
        channelName.textAlignment = .center

        container.spacing = 16
        container.axis = .vertical
        contentView.addSubview(container)

        layer.cornerRadius = 5
        layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImage.frame = contentView.bounds
        container.frame = contentView.bounds
        gradientLayer.frame = contentView.bounds
    }

    required init?(coder aDecoder: NSCoder) {
        container = UIStackView(arrangedSubviews: [showName, channelName])
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.showName.text = nil
        self.channelName.text = nil
    }

    func configure(for schedule: Schedule) {
        showName.text = schedule.displayName
        channelName.text = schedule.displayChannel
        backgroundImage.kf.indicatorType = .activity
        layoutIfNeeded()
    }
}
