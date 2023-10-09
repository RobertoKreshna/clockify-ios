//
//  AuthController.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 09/10/23.
//

import CoreData

class AuthController {
    func signUp(_ context: NSManagedObjectContext, email: String, password: String, confirmPassword: String) -> User? {
        let isEmailEmpty = checkStringEmpty(string: email)
        let isPwEmpty = checkStringEmpty(string: password)
        let isConfirmEmpty = checkStringEmpty(string: confirmPassword)

        // check ada yg ksong or no
        if isEmailEmpty || isPwEmpty || isConfirmEmpty {
            print("Somehting missing")
            return nil
        }

        // check confirmation bener ga
        if checkPw(pw: password, conf: confirmPassword) {
            let newUser = User(context: context)
            newUser.email = email
            newUser.password = password
            do {
                try context.save()
                return newUser
            } catch {
                print("Error saving new user \(error)")
                return nil
            }
        } else {
            print("confirmation salah")
            return nil
        }
    }

    func logIn(_ context: NSManagedObjectContext, email: String, pw: String) -> User? {
        let isEmailEmpty = checkStringEmpty(string: email)
        let isPwEmpty = checkStringEmpty(string: pw)

        // check kosong or no
        if isEmailEmpty || isPwEmpty {
            print("Something missing")
            return nil
        }

        // get all users
        var mailArray = [String]()
        var passwordArray = [String]()
        var userArray = [User]()
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let results = try context.fetch(request)
            for result in results {
                mailArray.append(result.email!)
                passwordArray.append(result.password!)
                userArray.append(result)
            }
        } catch {
            print("failed to get all users")
        }

        // check
        if mailArray.contains(email) {
            let userIndex = mailArray.firstIndex(where: { $0 == email })

            if passwordArray[userIndex!] == pw {
                print("ketemu")
                return userArray[userIndex!]
            }
        }

        return nil
    }

    func checkStringEmpty(string: String) -> Bool {
        return string == "" ? true : false
    }

    func checkPw(pw: String, conf: String) -> Bool {
        return pw == conf ? true : false
    }
}
