//
//  SwiftUIView.swift
//  drag-drop-filter
//
//  Created by Max Paris on 2/18/25.
//

import SwiftUI

struct DragUsingBinding: View {
    @State var elementDraggedId: String? = nil
    
    var body: some View {
        VStack {
            
            Spacer()
            
            HStack {
                Spacer()
                VStack {
                    Text("Circle trash")
                    Image(systemName: "trash")
                        .foregroundStyle(.white)
                        .font(.system(size: 50))
                        .padding()
                        .background(.black)
                        .cornerRadius(15)
                        .onDrop(of: ["public.text"], delegate: FiguresBindingDropDelegate(dropType: .circle, elementDraggedID: $elementDraggedId))
                }
                Spacer()
                VStack {
                    Text("Square trash")
                    Image(systemName: "trash")
                        .foregroundStyle(.white)
                        .font(.system(size: 50))
                        .padding()
                        .background(.black)
                        .cornerRadius(15)
                        .onDrop(of: ["public.text"], delegate: FiguresBindingDropDelegate(dropType: .rectangle, elementDraggedID: $elementDraggedId))
                }
                Spacer()
            }
            
            Spacer()
            
            
            HStack {
                Spacer()
                Circle()
                    .foregroundStyle(.orange)
                    .frame(width: 100, height: 100)
                    .contentShape([.dragPreview], Circle())
                    .onDrag {
                        elementDraggedId = DropTypes.circle.rawValue
                        return NSItemProvider(object: DropTypes.circle.rawValue as NSString)
                    }
                
                Spacer()
                
                Rectangle()
                    .foregroundStyle(.orange)
                    .frame(width: 100, height: 100)
                    .contentShape([.dragPreview], Rectangle())
                    .onDrag {
                        elementDraggedId = DropTypes.rectangle.rawValue
                        return NSItemProvider(object: DropTypes.rectangle.rawValue as NSString)
                    }
                
                Spacer()
            }
            Spacer()
        }
    }
}

class FiguresBindingDropDelegate: DropDelegate {
    @Binding var elementDraggedId: String?

    init(dropType: DropTypes, elementDraggedID: Binding<String?>) {
        self.dropType = dropType
        self._elementDraggedId = elementDraggedID
    }
    
    var dropType: DropTypes
    
    func performDrop(info: DropInfo) -> Bool {
        print("on performDrop")
        var droppedElementMatchesType = false
        let items = info.itemProviders(for: ["public.text"])
        _ = items.first?.loadObject(ofClass: String.self) { stringDropped, error in
            DispatchQueue.main.async {
                droppedElementMatchesType = stringDropped == self.dropType.rawValue
                
                if (droppedElementMatchesType) {
                    print("performing drop since types match")
                } else {
                    print("types dont match")
                }
            }
        }
        return droppedElementMatchesType
    }
    
    func dropEntered(info: DropInfo) {
        print("on dropEntered")
        
        //TODO: do something here to avoid
        guard elementDraggedId != nil, dropType.rawValue == elementDraggedId! else { return }
        
        print("performing move actions")
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
}
