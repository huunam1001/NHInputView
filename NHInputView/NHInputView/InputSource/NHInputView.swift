//
//  NHInputView.swift
//  NHInputView
//
//  Created by ninh nam on 4/28/20.
//  Copyright © 2020 ninh nam. All rights reserved.
//

import UIKit

let MARGIN_SIZE = 5 as CGFloat
let COLOR_CUSTOM_LIGHT_BLUE         =   UIColor(red: 0.086, green: 0.396, blue: 0.847, alpha: 1.0)

class NHInputView: UIView, UITextFieldDelegate {

    var titleLabel:UILabel!
    var inputText:UITextField!
    var errorLabel:UILabel!
    
    var validated = false
    
    var inputData = InputModel()
    
    func setView(_ input: InputModel, width:CGFloat)
    {
        self.inputData = input
        self.width = width
        
        titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.white
        titleLabel.text = " \(inputData.title) "
        titleLabel.sizeToFit()
        self.addSubview(titleLabel)
        titleLabel.left = MARGIN_SIZE*2
        
        titleLabel.isHidden = true
        
        inputText = UITextField()
        inputText.width = self.width
        inputText.height = MARGIN_SIZE*11
        
        inputText.layer.cornerRadius = MARGIN_SIZE
        inputText.layer.borderWidth = 1
        inputText.layer.borderColor = UIColor.lightGray.cgColor
        inputText.placeholder = inputData.placeholder
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: MARGIN_SIZE*2, height: inputText.height))
        inputText.leftView = paddingView
        inputText.leftViewMode = .always
        self.addSubview(inputText)
        inputText.top = titleLabel.height/2
        self.sendSubviewToBack(inputText)
        
        if(inputData.maskNumber.count > 0)
        {
            inputText.keyboardType = .numberPad
        }
        
        inputText.autocorrectionType = .no
        inputText.delegate = self
        inputText.addTarget(self, action: #selector(textFieldDidChange(_:)),
        for: .editingChanged)
        
        errorLabel = UILabel()
        
        
        if(inputData.validation != nil)
        {
            errorLabel.backgroundColor = UIColor.clear
            
            errorLabel.text = "\(inputData.validation!.errorString)"
            
            validated = false
            
//            errorLabel.sizeToFit()
//            self.addSubview(errorLabel)
//            errorLabel.left = MARGIN_SIZE*2
//            errorLabel.top = inputText.bottom + MARGIN_SIZE
//            errorLabel.textColor = UIColor.red
//
//            self.height = errorLabel.bottom
        }
        else
        {
            validated = true
            
            errorLabel.text = "You don't have validation"
            
            self.height = inputText.bottom
        }
        
        errorLabel.sizeToFit()
        self.addSubview(errorLabel)
        errorLabel.left = MARGIN_SIZE*2
        errorLabel.top = inputText.bottom + MARGIN_SIZE
        errorLabel.textColor = UIColor.red
        
        errorLabel.isHidden = true
        
        self.height = errorLabel.bottom
    }
    
    private func checkValidataion() -> Bool
    {
        if(inputData.validation != nil)
        {
            let textResult = NSPredicate(format:"SELF MATCHES %@", inputData.validation!.expression)
            
            validated = textResult.evaluate(with: inputText.text)
        }
        else
        {
            validated = true
        }
        
        return validated
    }
    
    func validationInput()
    {
        titleLabel.isHidden = false
        if(inputData.validation != nil)
        {
            if(self.checkValidataion())
            {
                errorLabel.isHidden = true
                inputText.layer.borderColor = COLOR_CUSTOM_LIGHT_BLUE.cgColor
                
                titleLabel.textColor = COLOR_CUSTOM_LIGHT_BLUE
            }
            else
            {
                errorLabel.isHidden = false
                inputText.layer.borderColor = UIColor.red.cgColor
                
                titleLabel.textColor = UIColor.red
            }
        }
        else
        {
            errorLabel.isHidden = true
            inputText.layer.borderColor = COLOR_CUSTOM_LIGHT_BLUE.cgColor
            
            titleLabel.textColor = COLOR_CUSTOM_LIGHT_BLUE
        }
    }
    
    func formattedNumber(number: String, format:String) -> String
    {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = format
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func getInputValue() -> String
    {
        return inputText.text ?? ""
    }
    
    func setText(_ text: String)
    {
        if(inputData.maskNumber.count > 0)
        {
            inputText.text = self.formattedNumber(number: text, format: inputData.maskNumber)
        }
        else
        {
            inputText.text = text
        }
        
        self.validationInput()
        
        if(self.checkValidataion())
        {
            inputText.layer.borderColor = UIColor.lightGray.cgColor
        }
        else
        {
            inputText.layer.borderColor = UIColor.red.cgColor
        }
        
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        inputText.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        inputText.layer.borderWidth = 2
        
        if(titleLabel.isHidden)
        {
            inputText.layer.borderColor = COLOR_CUSTOM_LIGHT_BLUE.cgColor
        }
        else
        {
            if(self.checkValidataion())
            {
                inputText.layer.borderColor = COLOR_CUSTOM_LIGHT_BLUE.cgColor
            }
            else
            {
                inputText.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        inputText.layer.borderWidth = 1
        
        self.validationInput()
        
        if(self.checkValidataion())
        {
            inputText.layer.borderColor = UIColor.lightGray.cgColor
        }
        else
        {
            inputText.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        if(inputData.maskNumber.count > 0)
        {
            let text = textField.text ?? ""
            
            textField.text = self.formattedNumber(number: text, format: inputData.maskNumber)
        }
        
        self.validationInput()
    }

}
