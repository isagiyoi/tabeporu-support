# tabeporu-support

タベポル（Tabeporu）の公開Webページ。GitHub Pages（`https://isagiyoi.github.io/tabeporu-support/`）で配信している。

## ページ

| ファイル | 公開URL | 内容 |
|---|---|---|
| `index.html` | `https://isagiyoi.github.io/tabeporu-support/` | サポート（App Store Connectの Support URL）。**変更していない** |
| `privacy.html` | `https://isagiyoi.github.io/tabeporu-support/privacy.html` | プライバシーポリシー（App Store Connectの Privacy Policy URL）。**変更していない** |
| `app.html` | `https://isagiyoi.github.io/tabeporu-support/app.html` | **公式紹介ページ（今回追加）** |

`index.html` と `privacy.html` はアプリの `ReleaseLinks.swift` から直接リンクされているため、
ファイル名・URLを変更しないこと。

## app.html（公式紹介ページ）

日本語1ページのみ。ブログ・CMS・別ページは持たない。

- Vanilla HTML/CSS のみ。ビルド不要、依存パッケージなし（既存2ページと同じ作法）
- 配色・書体は `index.html` / `privacy.html` と同じCSS変数を踏襲（ライト／ダーク対応）
- 画像は `assets/` 配下（アプリアイコンとApp Store提出用スクリーンショットのWeb用縮小版）
- バージョン番号に依存する記述は入れていない（アプリ更新のたびに直す必要がない）

### 構成

Hero → 今日どこで食べる？ → いつものお店から、今日の一軒。 → 使い方はシンプル。 →
いつものお店を、まとめて登録。 → 行ったお店を、カレンダーで振り返る。 →
静かに使えるアプリです。 → 新しいお店を探すより、好きなお店をもっと楽しむ。 → 最後のCTA → フッター

### 素材の出どころ

| 用途 | 元ファイル |
|---|---|
| スクリーンショット6枚 | `Tabeporu-Release-Assets/v1.1-final-listing-20260905-184647/screenshots/ja/`（App Store提出用の確定PNG） |
| アプリアイコン | `EncoreEats/Assets.xcassets/AppIcon.appiconset/AppIcon.png`（リリース中の実アイコン） |

いずれも元ファイルは変更していない。Web用に `sips` で縮小したコピーだけを `assets/` に置いている
（スクリーンショットは幅607px = 表示約300pxに対して2x、アイコンは32/180/512px）。

新しいロゴ・イラスト・料理写真・人物写真・ストック画像は使っていない。

## ローカル確認

```bash
cd ~/Documents/Development/tabeporu-support
python3 -m http.server 8765
# http://localhost:8765/app.html を開く
```

ブラウザ上で確認済みの内容:

| 項目 | 結果 |
|---|---|
| Desktop 1280px | 横スクロールなし。スクリーンショット3枚が横並び |
| Tablet 768px | 横スクロールなし。3枚横並び（各228px）、split 2カラム |
| iPhone 375 / 390px | 横スクロールなし。全セクション縦積み、スクリーンショット幅293px |
| 見出し階層 | h1（1つ）→ h2 → h3 |
| 画像 | 8枚すべてにalt、width/height指定、Hero以外はlazy loading |
| コントラスト | ライト: 本文11.59 / 補助文5.07 / リンク5.29 / CTA 5.92（すべてWCAG AA以上）<br>ダーク: 8.29〜15.52 |
| キーボード | Tabでリンク・CTAへ移動でき、focus表示あり（`:focus-visible`） |
| リンク | App Store・プライバシーポリシー・サポートいずれもHTTP 200 |

## 公開手順（人間の操作）

タベポル v1.1 は現在App Store審査中のため、**まだ公開しない**。公開は次の順序で行う。

1. v1.1 が承認される
2. 手動リリースする
3. App Storeで 1.1 が反映されたことを確認する
4. このページを公開する

公開の実作業:

1. このbranch（`claude/landing-page`）の内容を確認する
2. `main` へ取り込む（merge または PR）
3. `main` を GitHub へ push する
4. GitHub Pages のビルド完了後、`https://isagiyoi.github.io/tabeporu-support/app.html` を開いて確認する
5. 併せて `https://isagiyoi.github.io/tabeporu-support/` と `privacy.html` が従来どおり表示されることを確認する

> このリポジトリは `main` ブランチがそのまま GitHub Pages で公開される。
> push した時点で公開されるため、上記1〜3が済むまで push しないこと。

### 公開後に検討してよいこと（今回は未実施）

- 紹介ページを `/`（トップ）に置きたい場合は、サポートページの移設が必要になる。
  現在の `index.html` は App Store Connect に Support URL として登録済みのため、
  URLを変えるなら App Store Connect 側の登録変更もセットで行うこと。
- OGP画像は現在アプリアイコン（512px・正方形）を指定している。横長のOGP画像を用意する場合は差し替える。
