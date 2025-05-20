//
//  PhaseAnimatorExample.swift
//  CTabBar
//
//  Created by Rajesh Triadi Noftarizal on 20/05/25.
//

import SwiftUI

enum OSInfo: String, CaseIterable {
    case ios = "iOS"
    case appleWatch = "watchOS"
    case ipad = "iPadOS"
    case macbook = "macOS"
    case visionOS = "visionOS"
    
    var symbolImage: String {
        switch self {
        case .ios: "iphone"
        case .appleWatch: "applewatch"
        case .ipad: "ipad"
        case .macbook: "macbook"
        case .visionOS: "vision.pro"
        }
    }
}

struct PhaseAnimatorExample: View {
    @State private var isAnimationEnabled: Bool = false
    
    var body: some View {
        ZStack {
            if isAnimationEnabled {
                PhaseAnimator(OSInfo.allCases) { info in
                    VStack(spacing: 20) {
                        ZStack {
                            ForEach(OSInfo.allCases, id: \.rawValue) { osInfo in
                                let isSame = osInfo == info
                                
                                if isSame {
                                    Image(systemName: osInfo.symbolImage)
                                        .font(.system(size: 100, weight: .ultraLight, design: .rounded))
                                        .transition(.blurReplace(.upUp))
                                }
                            }
                        }
                        .frame(height: 120)
                        
                        VStack(spacing: 6) {
                            Text("Available On")
                                .font(.callout)
                                .foregroundStyle(.gray)
                            
                            ZStack {
                                ForEach(OSInfo.allCases, id: \.rawValue) { osInfo in
                                    let isSame = osInfo == info
                                    
                                    if isSame {
                                        Text(osInfo.rawValue)
                                            .font(.largeTitle)
                                            .fontWeight(.semibold)
                                            .fontDesign(.rounded)
                                            .transition(.push(from: .bottom))
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .clipped()
                        }
                    }
                } animation: { _ in
                    /// Delay between each slide
                        .interpolatingSpring(.bouncy(duration: 1, extraBounce: 0)).delay(1.5)
                }
            }
        }
        .task {
            isAnimationEnabled = true
        }
    }
}

#Preview {
    NavigationStack {
        PhaseAnimatorExample()
            .navigationTitle("Phase Animator")
            .navigationBarTitleDisplayMode(.inline)
    }
}
