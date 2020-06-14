//
//  MovieTableViewCell.swift
//  RxSearch
//
//  Created by Nir Leshem on 13/06/2020.
//  Copyright © 2020 Nir Leshem. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingView: UIView! {
        didSet {
            ratingView.layer.masksToBounds = true
            ratingView.layer.cornerRadius =  ratingView.frame.height / 2
        }
    }

    func configure(viewModel: MovieViewModel) {
        nameLabel.text = viewModel.name
        ratingLabel.text = "\(viewModel.rating)"
        ratingView.backgroundColor = viewModel.getScoreColor()
        contentView.backgroundColor = UIColor.getButtonBgColorOn()
    }
}
