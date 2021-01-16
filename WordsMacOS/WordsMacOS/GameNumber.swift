//
//  GameNumber.swift
//  WordsMacOS
//
//  Created by Камиль  Сулейманов on 15.01.2021.
//

import SwiftUI

struct GameNumber: View {
    var text: String
    var value: Int
    
    var body: some View {
        VStack{
        Text(text)
            .foregroundColor(.white)
            
            Text("\(value)")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
    }
}

struct GameNumber_Previews: PreviewProvider {
    static var previews: some View {
        GameNumber(text: "Счёт", value: 0)
    }
}
