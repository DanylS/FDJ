//
//  Player.swift
//  FDJ
//
//  Created by Danyl Semmache on 28/08/2019.
//  Copyright © 2019 Danyl Semmache. All rights reserved.
//

import Foundation
import UIKit

class PlayerModel {
    var firstName: String? = nil
    var lastName: String? = nil
    var role: String? = nil
    var birthday: Date? = nil
    var value: Int? = nil
    var face: UIImage? = nil

    init(firstName: String, lastName: String, role: String, birthday: Date, value: Int, face: UIImage) {
        self.firstName = firstName
        self.lastName = firstName
        self.role = role
        self.birthday = birthday
        self.value = value
        self.face = face
    }
}
