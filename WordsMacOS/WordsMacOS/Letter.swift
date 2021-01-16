//
//  Letter.swift
//  WordsMacOS
//
//  Created by Камиль  Сулейманов on 15.01.2021.
//

import SwiftUI

enum DragState{
    case unknown
    case good
    case bad
}
struct Letter: View {
    @State var dragAmmount: CGSize = .zero
    @State var dragState = DragState.unknown
    
    var text: String
    var index: Int
    var onChanged: ((CGPoint, String) -> DragState)?
    var onEnded: ((CGPoint, Int, String) -> Void)?
    
    var body: some View {
      Text(text)
        .font(.system(size: 40))
        .foregroundColor(.white)
        .frame(width: 80, height: 100)
        .background(dragAmmount == .zero ? Color.orange : dragColor)
        .cornerRadius(10)
        .shadow(radius: 10)
        .offset(dragAmmount)
        .zIndex(dragAmmount == .zero ? 0 : 1 )
        .gesture(
            DragGesture(coordinateSpace: .global)
                .onChanged {//value in
                    //$0 == value in
                    dragAmmount = CGSize(width: $0.translation.width, height: -$0.translation.height)
                    dragState = onChanged?($0.location, text) ?? .unknown
                }
                .onEnded { 
                    if dragState == .good {
                        onEnded?($0.location, index, text)
                    }
                    dragAmmount = .zero
                }
        )
    }
    
    var dragColor: Color{
        switch dragState {
        case .unknown:
            return .orange
        case .good:
            return .green
        case .bad:
            return .red   
    }
}
}

struct Letter_Previews: PreviewProvider {
    static var previews: some View {
        Letter(text: "А", index: 0)
    }
}
