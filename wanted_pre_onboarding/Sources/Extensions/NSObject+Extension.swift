//
//  NSObject+Extension.swift
//  wanted_pre_onboarding
//
//  Created by 한경수 on 2022/09/12.
//

import Foundation

extension NSObject {
  static var className: String {
    return String(describing: self).components(separatedBy: ".").last ?? ""
  }
}
