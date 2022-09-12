//
//  ImageCacher.swift
//  wanted_pre_onboarding
//
//  Created by 한경수 on 2022/09/12.
//

import Foundation
import UIKit

class ImageCacher {
  static let shared = ImageCacher()
  private init() { }
  
  var stoarge = NSCache<NSString, UIImage>()
}
