//
//  UIImageView+Extension.swift
//  wanted_pre_onboarding
//
//  Created by 한경수 on 2022/09/12.
//

import Foundation
import UIKit

extension UIImageView {
  func loadImage(_ path: String) {
    if let cached = ImageCacher.shared.stoarge.object(forKey: NSString(string: path)) {
      self.image = cached
      return
    }
    Task {
      do {
        guard
          let url = URL(string: path),
          let data = try await URLSession.shared.dataTask(with: url),
          let image = UIImage(data: data)
        else { return }
        ImageCacher.shared.stoarge.setObject(image, forKey: NSString(string: path))
        self.image = image
      } catch let error {
        debugPrint(error)
      }
    }
  }
}
