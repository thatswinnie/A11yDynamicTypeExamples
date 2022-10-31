//
//  ViewController.swift
//  A11yDynamicType
//
//  Created by Winnie Teichmann on 2022-07-28.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func didTapConstraints() {
        let viewController = ConstraintsViewController()
        navigationController?.show(viewController, sender: nil)
    }

    @IBAction func didTapHeight() {
        let viewController = HeightViewController()
        navigationController?.show(viewController, sender: nil)
    }

    @IBAction func didTapRelayout() {
        let viewController = RelayoutViewController()
        navigationController?.show(viewController, sender: nil)
    }

}

