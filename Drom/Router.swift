//
//  Router.swift
//  Drom
//
//  Created by Дмитрий on 01.12.2022.
//

import UIKit

final class Router {

    private let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        let mainVC = MainViewController()
        let navigation = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }

}
