//
//  ViewController.swift
//  NHInputView
//
//  Created by ninh nam on 4/28/20.
//  Copyright © 2020 ninh nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnCheck:UIButton!
    
    var mainDataList = [InputModel]()
    var viewList = [NHInputView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpShowingTextList()
        self.addTextComponents()
    }
    
    private func setUpShowingTextList()
    {
        /// Full name
        let fullNameValidation = ValidationModel(expression: ".{4,}",
                                                 errorString: "Full name must be at least 4 character")
        
        mainDataList.append(InputModel(title: "Full Name", placeholder: "Full Name *", maskNumber: "", validation: fullNameValidation))
                
        /// Full name
        let addressValidation = ValidationModel(expression: ".{1,}",
                                                errorString: "Address is null")
        
        mainDataList.append(InputModel(title: "Address", placeholder: "Address *", maskNumber: "", validation: addressValidation))
        
        
        mainDataList.append(InputModel(title: "Tel", placeholder: "Tel", maskNumber: "XXX XXX XXXX", validation: nil))
        
        
        /// email
        let emailValidation = ValidationModel(expression: "[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}",
                                                errorString: "You input wrong email format")
        
        mainDataList.append(InputModel(title: "Email", placeholder: "Email *", maskNumber: "", validation: emailValidation))
    }
    
    private func addTextComponents()
    {
        var top = btnCheck.bottom + 20.0
        
        for (index, item) in mainDataList.enumerated()
        {
            let inputView = NHInputView()
            inputView.setView(item, width: self.view.width - 40)
            
            
            
            inputView.tag = index + 1
            
            self.view.addSubview(inputView)
            
            viewList.append(inputView)
            
            inputView.left = 20.0
            inputView.top = top
            
            if(index == 3)
            {
                inputView.setText("abc@abc.com")
            }
            else if(index == 2)
            {
                inputView.setText("0934835001")
            }
            
            //
            top = inputView.bottom + 5.0
        }
    }
    
    @IBAction func nextAction(_ sender:Any)
    {
        let errorIndex = viewList.firstIndex(where: { $0.validated == false }) ?? -1
        
        
        if(errorIndex != -1)
        {
            for view in viewList
            {
                view.validationInput()
            }
        }
    }
}

