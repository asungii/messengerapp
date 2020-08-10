//
//  ProfileViewModel.swift
//  Messenger
//
//  Created by Laerdon Kim on 8/10/20.
//  Copyright © 2020 Laerdon Kim. All rights reserved.
//

import Foundation

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
