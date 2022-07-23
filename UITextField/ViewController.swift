//
//  ViewController.swift
//  UITextField
//
//  Created by Дмитрий Процак on 24.07.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var login: UITextField!
    var password = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //делегируем
        login.delegate = self
        
        //делегируем
        view.addSubview(password)
        password.delegate = self
        password.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            password.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 32),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        password.borderStyle = .roundedRect
        password.placeholder = "enter password"
        //скрытые написание
        password.isSecureTextEntry = true
        //введение только цыфр
         //password.keyboardType = .phonePad
        //цвет клавиатуры
        password.keyboardAppearance = .dark
        //отображение кнопки удаления
        password.clearButtonMode = .always
        
        /*
         при запуске приложения клавиатура выводеться и мы сразу можем вводить данные в строку password
        password.becomeFirstResponder()
         */
    }


}


//добовляем расширение чтобя проделегировать
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == login {
            password.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
