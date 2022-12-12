//
//  MainCell.swift
//  Drom
//
//  Created by Дмитрий on 01.12.2022.
//

import UIKit

final class MainCell: UICollectionViewCell {

    private let imageView = UIImageView()
    private let loader = UIActivityIndicatorView(style: .medium)

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        clipsToBounds = true

        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)

        loader.startAnimating()
        contentView.addSubview(loader)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        imageView.frame = contentView.bounds
        loader.center = contentView.center
    }

    func setImage(_ image: UIImage?) {
        image != nil ? loader.stopAnimating() : loader.startAnimating()
        imageView.image = image
    }
    
}
