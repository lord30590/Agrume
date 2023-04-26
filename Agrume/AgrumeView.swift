//
//  Copyright © 2021 Schnaub. All rights reserved.
//

import SwiftUI
import UIKit

@available(iOS 14.0, *)
public struct AgrumeView: View {
    @Namespace var namespace
    private let images: [UIImage]
    private let startIndex: Int
    @Binding private var isPresenting: Bool
    
    public init(images: [UIImage], startIndex: Int, isPresenting: Binding<Bool>) {
        self.images = images
        self.startIndex = startIndex
        self._isPresenting = isPresenting
    }
    
    public var body: some View {
        WrapperAgrumeView(images: images, startIndex: startIndex, isPresenting: $isPresenting)
            .id(images)
            .matchedGeometryEffect(id: "AgrumeView", in: namespace, properties: .frame, isSource: isPresenting)
            .ignoresSafeArea()
    }
}

@available(iOS 13.0, *)
struct WrapperAgrumeView: UIViewControllerRepresentable {
    
    let images: [UIImage]
    let startIndex: Int
    @Binding var isPresenting: Bool
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<WrapperAgrumeView>) -> UIViewController {
        let agrume = Agrume(images: images, startIndex: startIndex)
        agrume.view.backgroundColor = .clear
        agrume.addSubviews()
        agrume.addOverlayView()
        agrume.willDismiss = {
            withAnimation {
                isPresenting = false
            }
        }
        return agrume
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController,
                                       context: UIViewControllerRepresentableContext<WrapperAgrumeView>) {
    }
}


struct TestView: View {
    var body: some View {
        if #available(iOS 14.0, *) {
            AgrumeView(images: [], startIndex: 0, isPresenting: .constant(false))
        } else {
            // Fallback on earlier versions
        }

    }
}
