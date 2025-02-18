import SwiftUI

enum DropTypes: String {
    case rectangle, circle
}

struct ContentView: View {
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
                        .onDrop(of: ["public.text"], delegate: FiguresDropDelegate(dropType: .circle))
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
                        .onDrop(of: ["public.text"], delegate: FiguresDropDelegate(dropType: .rectangle))
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
                    .onDrag { NSItemProvider(object: "circle" as NSString) }
                
                Spacer()
                
                Rectangle()
                    .foregroundStyle(.orange)
                    .frame(width: 100, height: 100)
                    .contentShape([.dragPreview], Rectangle())
                    .onDrag {
                        NSItemProvider(object: "rectangle" as NSString)
                    }
                
                Spacer()
            }
            Spacer()
        }
    }
}

class FiguresDropDelegate: DropDelegate {
    
    init(dropType: DropTypes) {
        self.dropType = dropType
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
                    print("performing drop since types matches")
                } else {
                    print("types dont match")
                }
            }
        }
        return droppedElementMatchesType
    }
    
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
}
