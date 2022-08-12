//
//  UIConstants.swift
//  GithubRepositories
//
//  Created by Maedeh DAEMI on 03/08/2022.
//

import Foundation
import UIKit
func sizeWithRatio( _ size: CGFloat) -> CGFloat{
    return (screenWidth / 320) * size
}
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let marginSize = sizeWithRatio(10)
let paddingSize = sizeWithRatio(15)
let buttonHeight = sizeWithRatio(42)
let avatarSize = screenWidth * 0.25
let profileImageSize = avatarSize * 0.8
let fullSize = screenWidth - 2 * paddingSize
let dotSize = screenWidth/50
let font10 = sizeWithRatio(10)
let font11 = sizeWithRatio(11)
let font12 = sizeWithRatio(12)
let font14 = sizeWithRatio(14)
let font18 = sizeWithRatio(18)
let font8 = sizeWithRatio(8)
let font16 = sizeWithRatio(16)
let cornerSize = sizeWithRatio(10)
