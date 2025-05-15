//
//  AppCoordinator.swift
//  JsonApp
//
//  Created by Marcell Fulop on 5/14/25.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func start()-> UINavigationController
    func navigateToCountryDetails(country: Country)
}

final class AppCoordinator: Coordinator {
    private var navigationController = UINavigationController()
    private let sb = UIStoryboard(name: "Main", bundle: nil)
    
    private func getViewController<T: UIViewController>(kind: T.Type, identifier: String) -> UIViewController{
        if let vc = sb.instantiateViewController(withIdentifier: identifier) as? T {
                return vc
        }
        return T()
    }
    
    func start() -> UINavigationController {
        guard let vc = getViewController(kind: CountryListViewController.self, identifier: "CountryListViewController") as? CountryListViewController else {
            // casting or instantiation failed
            return navigationController
        }
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: true)
        return navigationController
    }
    
    func navigateToCountryDetails(country: Country) {
        guard let vc = getViewController(kind: CountryDetailsViewController.self, identifier: "CountryDetailsViewController") as? CountryDetailsViewController else {
            return
        }
        vc.country = country
        navigationController.pushViewController(vc, animated: true)
        
    }
}
