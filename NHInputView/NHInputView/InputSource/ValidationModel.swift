//
//  ValidationModel.swift
//  NHInputView
//
//  Created by ninh nam on 4/28/20.
//  Copyright © 2020 ninh nam. All rights reserved.
//

import UIKit

class ValidationModel: NSObject
{
    var expression: String = ""
    var errorString: String = ""
    
    init(expression: String, errorString:String)
    {
        self.expression = expression
        self.errorString = errorString
    }
}
