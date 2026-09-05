// タベポル 紹介ページのOGP画像（1200x630）を生成する。
// 素材はリポジトリ内の実アイコンと実スクリーンショットのみを使う。
//   swift tools/make-ogp.swift
import AppKit
import CoreGraphics
import ImageIO
import UniformTypeIdentifiers

let W = 1200, H = 630

// app.html と同じセマンティックカラー（ライト側）
func rgb(_ hex: UInt32, _ a: CGFloat = 1) -> CGColor {
    CGColor(red: CGFloat((hex >> 16) & 0xff) / 255,
            green: CGFloat((hex >> 8) & 0xff) / 255,
            blue: CGFloat(hex & 0xff) / 255, alpha: a)
}
let bg = rgb(0xF4F2EE), text = rgb(0x24352C), warm = rgb(0xBC7B5C), accent = rgb(0x4C6B57), muted = rgb(0x5D6A63)

let repoRoot = URL(fileURLWithPath: CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : ".")
func loadImage(_ rel: String) -> CGImage {
    let url = repoRoot.appendingPathComponent(rel)
    guard let src = CGImageSourceCreateWithURL(url as CFURL, nil),
          let img = CGImageSourceCreateImageAtIndex(src, 0, nil) else {
        fatalError("読み込めません: \(url.path)")
    }
    return img
}

guard let ctx = CGContext(data: nil, width: W, height: H, bitsPerComponent: 8, bytesPerRow: 0,
                          space: CGColorSpaceCreateDeviceRGB(),
                          bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) else {
    fatalError("CGContextを作れません")
}
// 座標は左下原点。上端からの位置で書けるようにする。
func fromTop(_ top: CGFloat, height h: CGFloat) -> CGFloat { CGFloat(H) - top - h }

ctx.setFillColor(bg)
ctx.fill(CGRect(x: 0, y: 0, width: W, height: H))

// Loop Motif の円弧（app.html のヒーローと同じ考え方で上部に流す）
func arc(diameter d: CGFloat, left: CGFloat, top: CGFloat, color: CGColor, width lw: CGFloat) {
    ctx.saveGState()
    ctx.setStrokeColor(color)
    ctx.setLineWidth(lw)
    ctx.strokeEllipse(in: CGRect(x: left, y: fromTop(top, height: d), width: d, height: d))
    ctx.restoreGState()
}
// 見出しの上を横切らないよう、円弧は上端の帯だけを通す。
arc(diameter: 900, left: -330, top: -600, color: rgb(0x4C6B57, 0.24), width: 46)
arc(diameter: 820, left: 520, top: -520, color: rgb(0xBC7B5C, 0.30), width: 46)

let gctx = NSGraphicsContext(cgContext: ctx, flipped: false)
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = gctx

func draw(_ s: String, x: CGFloat, top: CGFloat, size: CGFloat, weight: NSFont.Weight, color: CGColor, tracking: CGFloat = 0) -> CGFloat {
    let font = NSFont.systemFont(ofSize: size, weight: weight)
    let attrs: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: NSColor(cgColor: color)!,
        .kern: tracking,
    ]
    let str = NSAttributedString(string: s, attributes: attrs)
    let h = ceil(font.ascender - font.descender)
    str.draw(at: NSPoint(x: x, y: fromTop(top, height: h) - font.descender * 0.5))
    return h
}

// 右側：Todayのスクリーンショット（下端はキャンバスで切れる＝サイトのヒーローと同じ見せ方）
let shot = loadImage("assets/screenshots/01_today_decides.png")
let shotW: CGFloat = 372
let shotH = shotW * CGFloat(shot.height) / CGFloat(shot.width)
let shotRect = CGRect(x: 762, y: fromTop(74, height: shotH), width: shotW, height: shotH)
ctx.saveGState()
ctx.setShadow(offset: CGSize(width: 0, height: -14), blur: 40, color: rgb(0x000000, 0.16))
let clip = CGPath(roundedRect: shotRect, cornerWidth: 30, cornerHeight: 30, transform: nil)
ctx.addPath(clip)
ctx.clip()
ctx.draw(shot, in: shotRect)
ctx.restoreGState()

// 左側：アイコン → ブランド名 → 見出し → 補足
let icon = loadImage("assets/icon/appicon-512.png")
let iconSide: CGFloat = 92
let iconRect = CGRect(x: 76, y: fromTop(92, height: iconSide), width: iconSide, height: iconSide)
ctx.saveGState()
ctx.setShadow(offset: CGSize(width: 0, height: -5), blur: 16, color: rgb(0x000000, 0.12))
ctx.addPath(CGPath(roundedRect: iconRect, cornerWidth: 21, cornerHeight: 21, transform: nil))
ctx.clip()
ctx.draw(icon, in: iconRect)
ctx.restoreGState()

_ = draw("タベポル", x: 78, top: 210, size: 27, weight: .bold, color: warm, tracking: 1.2)
_ = draw("今日のお店が、", x: 76, top: 258, size: 74, weight: .bold, color: text, tracking: -1)
_ = draw("すぐ決まる。", x: 76, top: 352, size: 74, weight: .bold, color: text, tracking: -1)
_ = draw("いつものお店から「今日の一軒」を提案するiPhoneアプリ。", x: 78, top: 468, size: 25, weight: .regular, color: muted)
_ = draw("アカウント不要・広告なし・無料", x: 78, top: 516, size: 25, weight: .semibold, color: accent)

NSGraphicsContext.restoreGraphicsState()

guard let out = ctx.makeImage() else { fatalError("画像化に失敗") }
let dest = repoRoot.appendingPathComponent("assets/og/ogp-1200x630.png")
guard let sink = CGImageDestinationCreateWithURL(dest as CFURL, UTType.png.identifier as CFString, 1, nil) else {
    fatalError("出力先を作れません")
}
CGImageDestinationAddImage(sink, out, nil)
guard CGImageDestinationFinalize(sink) else { fatalError("書き出しに失敗") }
print("生成: \(dest.path)  \(out.width)x\(out.height)")
