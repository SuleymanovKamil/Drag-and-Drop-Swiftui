//
//  ResetButton.swift
//  WordsMacOS
//
//  Created by Камиль  Сулейманов on 15.01.2021.
//

import SwiftUI

struct ResetButton: View {
    var action: (() -> Void)?
    
    var body: some View {
        Group{
            VStack{
            Button(action: {action?()}, label: {
                Text("Сброс")
                        .font(.title)
                        .padding()
            })
            .buttonStyle(BorderlessButtonStyle())
            .background(Color.green)
            .clipShape(Capsule())
            .background(Color.white)
            
            Text("Минус 10 очков")
                .font(.headline)
                .foregroundColor(.white)
                .shadow(color: .red, radius:5)
                .shadow(color: .red, radius:5)
        }
        }
    }
}

struct ResetButton_Previews: PreviewProvider {
    static var previews: some View {
        ResetButton()
    }
}
