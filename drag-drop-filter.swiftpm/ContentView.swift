import SwiftUI

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
                }
                Spacer()
            }
            
            Spacer()
            
            
            HStack {
                Spacer()
                Circle()
                    .foregroundStyle(.orange)
                    .frame(width: 100, height: 100)
                    .onDrag { NSItemProvider() }
                
                Spacer()
                
                Rectangle()
                    .foregroundStyle(.orange)
                    .frame(width: 100, height: 100)
                Spacer()
            }
            Spacer()
        }
    }
}
