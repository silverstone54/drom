//
//  Extensions.swift
//  Drom
//
//  Created by Дмитрий on 02.12.2022.
//

import UIKit

extension UICollectionViewCell {
    static let identifier = String(describing: self)
}

extension UIImage {

    func resizeIfNeededTo(width: CGFloat) -> UIImage? {
        if self.size.width <= width {
            return self
        }
        let scale: CGFloat = width / self.size.width
        let height = self.size.height * scale
        let size = CGSize(width: width, height: height)

        UIGraphicsBeginImageContextWithOptions(size, true, 1)
        self.draw(in: .init(origin: .zero, size: size))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return result
    }

}
