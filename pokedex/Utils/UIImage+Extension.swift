//
//  UIImage+Extension.swift
//  pokedex
//
//  Created by francisco rafael aguilar lugo on 11/09/23.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from urlString: String) {
        let url = URL(string: urlString)
        guard let imageURL = url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}
