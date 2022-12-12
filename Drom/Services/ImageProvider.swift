//
//  ImageProvider.swift
//  Drom
//
//  Created by Дмитрий on 02.12.2022.
//

import UIKit

protocol ImageProviderDelegate: AnyObject {
    func didLoadImage(at url: URL)
}

final class ImageProvider {

    private let cache = NSCache<NSURL, UIImage>()
    private var queue = [URL]()

    weak var delegate: ImageProviderDelegate?

    func getImage(at url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }

    func loadImage(at url: URL) {
        if queue.contains(url) {
            return
        }
        queue.append(url)

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            self.queue.removeAll { $0 == url }
            self.cache.setObject(image, forKey: url as NSURL)
            self.delegate?.didLoadImage(at: url)

            print("download image", image.size)
        }.resume()
    }

}
