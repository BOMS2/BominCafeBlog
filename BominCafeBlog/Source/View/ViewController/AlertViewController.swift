//
//  AlertViewController.swift
//  BominCafeBlog
//
//  Created by 김보민 on 2021/03/12.
//

import UIKit

class AlertViewController: UIAlertController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setup()
		self.setLayout()
	}
}

extension AlertViewController {
	private func setup() {
		self.view.backgroundColor = .white
	}

	private func setLayout() {
	}
}
