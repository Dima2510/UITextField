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
    var validator = Validator()
    var storage = Storage.initial
    
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


//Добовляем расширение чтобя проделегировать
extension ViewController: UITextFieldDelegate {
    
    //метод который указывет на то что после ведения логина и нажатия кнопки done нас автоматом перекидывает на строку password
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == login {
            password.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    //Будет ли вводиться определееный текст
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case login:
            break
            //не хочу чтобы что то вводилось кроме цифр
        case password: return validator.hasNumbers(text: string)
            
        default: break
        }
        return true
    }
    
    
    //нельзя удалить текст,если мы редактируем другую строку,чтобы ее удалить надо обратно в нее вернуться
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField.isEditing {
            return true
        }
        return false
    }
    
    //хотим сделать что при в воде логина и пароля они будут сохраняться локально и в дополненни выводиться в консоль
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == login {
            storage.login = textField.text!
        } else {
            storage.password = textField.text!
            print(storage.login, storage.password)
        }
    }
    
}
    
    
    struct Validator {
        let numbers = "123456789"
        //проверяет что текст не содержит что то кроме цифр
        func hasNumbers(text: String) -> Bool {
            for oneNumber in numbers {
                if text.contains(oneNumber) {return true}
            }
            return false
        }
    }
    


struct Storage {
    var login = ""
    var password = ""
    
    static let initial = Storage()
}
