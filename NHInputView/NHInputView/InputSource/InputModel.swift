//
//  InputModel.swift
//  NHInputView
//
//  Created by ninh nam on 4/28/20.
//  Copyright © 2020 ninh nam. All rights reserved.
//

import UIKit

class InputModel: NSObject
{
    var title: String = ""
    var placeholder: String = ""
    var maskNumber: String = ""
    var validation: ValidationModel?

    init(title: String, placeholder: String, maskNumber:String, validation:ValidationModel?)
    {
        self.title = title
        self.placeholder = placeholder
        self.maskNumber = maskNumber
        self.validation = validation
    }
}
