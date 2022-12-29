//
//  ViewController.swift
//  Dz12
//
//  Created by Admin on 29/12/2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - UI Elements

    private lazy var clockFaceLable: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        return label
    }()

    private lazy var startStopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        button.tintColor = UIColor.systemGray
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 60), forImageIn: .normal)
        return button
    }()

    private lazy var labelButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 30
        stack.addArrangedSubview(clockFaceLable)
        stack.addArrangedSubview(startStopButton)
        return stack
    }()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setups

    private func setupView() {
        view.backgroundColor = .black
    }

    private func setupHierarchy() {
        view.addSubview(labelButtonStack)
    }

    private func setupLayout() {
        labelButtonStack.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
    }

    // MARK: - Actions

}

