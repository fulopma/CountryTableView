//
//  ViewController.swift
//  JsonApp
//
//  Created by Marcell Fulop on 4/25/25.
//

import UIKit
import Foundation

// 1. understand above JSON data
// 2. create model from above Json data
// 3.  store json data locally in .json file
// 4. read the local json file and parese json data using JSONDecoder
// 5. populate read countries data into table view.

struct Country: Decodable {
    let capital: String
    let code: String
    let currency: Currency
    let flag: String
    let language: Language
    let name: String
    let region: String
}

struct Currency: Decodable {
    let code: String
    let name: String
    let symbol: String
}

struct Language: Decodable {
    let code: String
    let name: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

