//
//  MorphingCircle.swift
//  Paletto
//
//  Created by Gina Mahaz on 11/24/25.
//

import Foundation
import SwiftUI

//var animatableData: AnimatableVector {
//    get { animatedValue }
//    set { animatedValue = newValue }
//}

extension CGPoint {
    public static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func +(lhs: CGPoint, rhs: CGVector) -> CGPoint {
        CGPoint(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
    }
    
    static func -(lhs: CGPoint, rhs: CGVector) -> CGPoint {
        CGPoint(x: lhs.x - rhs.dx, y: lhs.y - rhs.dy)
    }
    
    public static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    init(_ vec: CGVector) {
        self = CGPoint(x: vec.dx, y: vec.dy)
    }
}

extension CGPoint: VectorArithmetic {
    public mutating func scale(by rhs: Double) {
        x = CGFloat(rhs) * x
        y = CGFloat(rhs) * y
    }
    
    public var magnitudeSquared: Double {
        Double(x * x + y * y)
    }
    

}

extension CGVector {
    init(_ point: CGPoint) {
        self = CGVector(dx: point.x, dy: point.y)
    }
    
    func scalar(_ vec: CGVector) -> CGFloat {
        dx * vec.dx + dy * vec.dy
    }
    
    func len() -> CGFloat {
        sqrt(dx * dx + dy * dy)
    }
    
    func perpendicular() -> CGVector {
        CGVector(dx: -dy, dy: dx) / len()
    }
    
    static func *(lhs: CGVector, rhs: CGFloat) -> CGVector {
        CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
    }
    
    static func *(lhs: CGFloat, rhs: CGVector) -> CGVector {
        CGVector(dx: rhs.dx * lhs, dy: rhs.dy * lhs)
    }
    
    static func /(lhs: CGVector, rhs: CGFloat) -> CGVector {
        CGVector(dx: lhs.dx / rhs, dy: lhs.dy / rhs)
    }
    
    static func -(lhs: CGVector, rhs: CGVector) -> CGVector {
        CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
    }
    
    static func +(lhs: CGVector, rhs: CGVector) -> CGVector {
        CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
    }
    
    func angle(_ rhs: CGVector) -> CGFloat {
        return acos(scalar(rhs) / (rhs.len() * len()))
    }
}

//shape code//

struct MorphingCircleShape: Shape {
    let pointsNum: Int
    var morphing: AnimatableVector
    let tangentCoeficient: CGFloat
    
    var animatableData: AnimatableVector {
        get { morphing }
        set { morphing = newValue }
    }
    
    // Calculates control points
    func getTwoTangent(center: CGPoint, point: CGPoint) -> (first: CGPoint, second: CGPoint) {
        let a = CGVector(center - point)
        let dir = a.perpendicular() * a.len() * tangentCoeficient
        return (point - dir, point + dir)
    }
    
    // Draw circle
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.width / 2, rect.height / 2)
        let center =  CGPoint(x: rect.width / 2, y: rect.height / 2)
        var nextPoint = CGPoint.zero
        
        let ithPoint: (Int) -> CGPoint = { i in
            let point = center + CGPoint(x: radius * sin(CGFloat(i) * CGFloat.pi * CGFloat(2) / CGFloat(pointsNum)),
                                         y: radius * cos(CGFloat(i) * CGFloat.pi * CGFloat(2) / CGFloat(pointsNum)))
            var direction = CGVector(point - center)
            direction = direction / direction.len()
            return point + direction * CGFloat(morphing[i >= pointsNum ? 0 : i])
        }
        var tangentLast = getTwoTangent(center: center,
                                        point: ithPoint(pointsNum - 1))
        for i in (0...pointsNum){
            nextPoint = ithPoint(i)
            let tangentNow = getTwoTangent(center: center, point: nextPoint)
            if i != 0 {
                path.addCurve(to: nextPoint, control1: tangentLast.1, control2: tangentNow.0)
            } else {
                path.move(to: nextPoint)
            }
            tangentLast = tangentNow
        }
        
        path.closeSubpath()
        return path
    }
    
    
    init(_ morph: AnimatableVector) {
        pointsNum = morph.count
        morphing = morph
        tangentCoeficient = (4 / 3) * tan(CGFloat.pi / CGFloat(2 * pointsNum))
    }
}

//timer//

struct MorphingCircle: View & Identifiable & Hashable {
    static func == (lhs: MorphingCircle, rhs: MorphingCircle) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID()
    @State var morph: AnimatableVector = AnimatableVector.zero
    @State var timer: Timer?
    
    func morphCreator() -> AnimatableVector {
        let range = Float(-morphingRange)...Float(morphingRange)
        var morphing = Array.init(repeating: Float.zero, count: self.points)
        for i in 0..<morphing.count where Int.random(in: 0...1) == 0 {
            morphing[i] = Float.random(in: range)
        }
        return AnimatableVector(values: morphing)
    }
    
    func update() {
        morph = morphCreator()
    }
    
    let duration: Double
    let points: Int
    let secting: Double
    let size: CGFloat
    let outerSize: CGFloat
    var color: Color
    let morphingRange: CGFloat
    
    var radius: CGFloat {
        outerSize / 2
    }
    var body: some View {
            MorphingCircleShape(morph)
                .fill(color)
        
        // remove this and blur modifier to go back to solid colors //
        
                .fill(AngularGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple]), center: .bottom))
                .blur(radius: 25)
                .frame(width: size, height: size, alignment: .center)
                .animation(Animation.easeInOut(duration: Double(duration + 1.0)), value: morph)
                .onAppear {
                    update()
                    timer = Timer.scheduledTimer(withTimeInterval: duration / secting, repeats: true) { timer in
                        update()
                    }
                }.onDisappear {
                    timer?.invalidate()
                }
                .frame(width: outerSize, height: outerSize, alignment: .center)
                .animation(nil, value: morph)
            
        }
        
        init(_ size:CGFloat = 300, morphingRange: CGFloat = 30, color: Color = .red, points: Int = 4,  duration: Double = 5.0, secting: Double = 2) {
            self.points = points
            self.color = color
            self.morphingRange = morphingRange
            self.duration = duration
            self.secting = secting
            self.size = morphingRange * 2 < size ? size - morphingRange * 2 : 5
            self.outerSize = size
            morph = AnimatableVector(values: [])
            update()
        }
        
        func color(_ newColor: Color) -> MorphingCircle {
            var morphNew = self
            morphNew.color = newColor
            return morphNew
        }
    }

#Preview {
    ZStack {
        MorphingCircle(color: .blue)
        MorphingCircle(morphingRange: 55, color: .mint)
            .opacity(0.75)
        Text("A#")
            .font(Font.custom("Silom", size: 48))
            .foregroundColor(Color.white)
            .shadow(radius: 6)
            .background {
//                RoundedRectangle(cornerRadius: 16, color: .blue)
                    
                    
            }
    }
}
