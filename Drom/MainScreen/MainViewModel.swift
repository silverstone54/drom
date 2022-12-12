//
//  MainViewModel.swift
//  Drom
//
//  Created by Дмитрий on 02.12.2022.
//

import Foundation

struct MainCellViewModel {
    let imageURL: String
}

final class MainViewModel {

    private var urls = [String]()
    private(set) var cellsVM = [MainCellViewModel]()

    init() {
        urls.append(contentsOf: [
            "https://s.auto.drom.ru/photo/CAK73hG4n_FFbXeu1P0SwbjX3Vxe0SNy938dn2921cCBs8WrsZLVc_e5Ja02nM98OIICMZLNM4VuQ1dhc7E5N_cKnic8.jpg",
            "https://s.auto.drom.ru/photo/vX1gTEBQn7L2ONhJShYbcFzKr9U1zknvK_7n3LsnVyOgZcL_qx_GpkHTLPq-OGxoC2sM04Y1558y9aB6ucPYqMRKEARB.jpg",
            "https://s.auto.drom.ru/photo/dC6h7PCBiBD9tnzIG3YfglaFYEk0J-Nikq6R0lWRtodQENSOFctdoqu9Ru5TjmnjnJapuIAUpWsCvYhb84QferSr55VN.jpg",
            "https://s.auto.drom.ru/photo/iZ66JYRI8wTqVXnyu5aoE7hT3sxsv7HBTlhKALd9CjMSm1aV7AnrleULXW59I5sru_SQQgD5t-lQoV1CCiJLCyoq52oh.jpg",
            "https://s.auto.drom.ru/photo/1sySnpL7mMcN6MF5NG9ppEj0pa0cila9hOTRsrQhH1qg6TW1bRDBUfKj3XrgqGKcPhjqd6kSrxduwPeCZcC4Q5Qmju8V.jpg",
            "https://s.auto.drom.ru/photo/rYJwLxnEDkEhBDNYSJq5TjA-lxn68vq4_L-kChbcAHerfDXhIasnv3BP9L3cCcEDu8UByC5BiGWZrE_WaJGtyyoBkd9C.jpg"
        ])
        loadCellsVM()
    }

    func loadCellsVM() {
        cellsVM = urls.map { MainCellViewModel(imageURL: $0) }
    }

    func removeCell(at index: Int) {
        cellsVM.remove(at: index)
    }

}
