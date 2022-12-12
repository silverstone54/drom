//
//  MainViewController.swift
//  Drom
//
//  Created by Дмитрий on 01.12.2022.
//

import UIKit

final class MainViewController: UIViewController {

    private let inset: CGFloat = 10

    private let viewModel = MainViewModel()
    private let imageProvider = ImageProvider()

    private let refreshControl = UIRefreshControl()
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Main"
        view.backgroundColor = .white

        imageProvider.delegate = self

        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)

        setupCollection()
    }

}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cellsVM.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath)
        guard let mainCell = cell as? MainCell else {
            fatalError("Invalid cell")
        }
        let cellVM = viewModel.cellsVM[indexPath.item]

        mainCell.setImage(nil)
        mainCell.isHidden = false

        if let url = URL(string: cellVM.imageURL) {
            let size = UIScreen.main.bounds.size
            let width = max(size.width, size.height)

            if let image = imageProvider.getImage(at: url)?.resizeIfNeededTo(width: width) {
                mainCell.setImage(image)
            } else {
                imageProvider.loadImage(at: url)
            }
        }
        return mainCell
    }

}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)

        UIView.animate(withDuration: 0.3) {
            cell?.transform = .init(translationX: self.view.bounds.width, y: 0)
        } completion: { _ in
            cell?.isHidden = true

            collectionView.performBatchUpdates {
                self.viewModel.removeCell(at: indexPath.item)
                collectionView.deleteItems(at: [indexPath])
            } completion: { _ in
                collectionView.collectionViewLayout.invalidateLayout()
            }
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return .init(width: width - inset * 2, height: width)
    }

}

// MARK: - ImageProviderDelegate

extension MainViewController: ImageProviderDelegate {

    func didLoadImage(at url: URL) {
        guard let index = viewModel.cellsVM.firstIndex(where: { $0.imageURL == url.absoluteString }) else {
            return
        }
        let path = IndexPath(item: index, section: 0)

        DispatchQueue.main.async {
            self.collectionView.reloadItems(at: [path])
        }
    }

}

// MARK: - Private

private extension MainViewController {

    func setupCollection() {
        collectionView = .init(frame: view.bounds, collectionViewLayout: makeLayout())
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.identifier)
        collectionView.refreshControl = refreshControl
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
    }

    func makeLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = inset
        return layout
    }

    @objc
    func reload() {
        viewModel.loadCellsVM()
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }

}
