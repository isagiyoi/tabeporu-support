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

## 検索・生成AI検索（AI Overviews / AI Mode）への考え方

Google Search Central の
[AI features and your website](https://developers.google.com/search/docs/appearance/ai-features)
の記載に沿っている（2026-09-05 参照）。Googleは同ページで
「AI OverviewsやAI Modeに出るための追加要件や特別な最適化はない」
「新しい機械可読ファイル・AI用テキストファイル・専用マークアップを作る必要はなく、
専用のstructured dataもない」と明記している。

そのため、このページでやっているのは通常の検索向けの基本だけ。

- クロール・インデックス・スニペット表示を妨げない（`robots` メタ指定なし、`nosnippet` なし。
  リポジトリに `robots.txt` を置いていないため、Googlebotのブロックもない）
- 重要な情報を画像ではなく**テキスト**で書く
- タベポルでしか得られない独自情報を可視の本文として明記する
  （新しい店を探すアプリではない／いつものお店から今日の一軒を決める／
  「ここに決める」で決定と訪問記録が同時に終わる／食後に開き直す必要がない／
  訪問の記録などをもとに提案が変わる／駅名・地名からまとめて登録できる／
  アカウント不要・広告なし・データ収集なし／登録したお店と訪問履歴は端末に保存）
- 「タベポルについて」に、実際に聞かれる質問だけを5問置く

意図的にやっていないこと:

- `llms.txt` などAI向けの独自ファイルの追加（Googleが不要と明記しているため）
- AI向けの隠しテキスト、キーワード羅列
- SEO目的のQ&A大量生成、内容が同じ派生ページの量産
- 他のグルメアプリへの根拠のない比較・批判
- 「AIに引用される」といった保証めいた表現

## 構造化データ

`app.html` に `MobileApplication` のJSON-LDを1つだけ置いている。
[Software app structured data](https://developers.google.com/search/docs/appearance/structured-data/software-app)
の仕様に合わせた（2026-09-05 参照）。

- `@type`: `MobileApplication`（Googleがサポートする3種の1つ）
- `applicationCategory`: **`LifestyleApplication`**。
  Googleの Recommended properties にある「supported app types」は22種類の固定リストで、
  `LifestyleApplication` は含まれ、`Food & Drink` は含まれない。
- `applicationSubCategory`: 「フード／ドリンク」（App Store上の実際のカテゴリー）。
  schema.orgとしては有効だが、**Googleの必須・推奨プロパティには入っておらず、
  リッチリザルトでは使われない**。事実として正しいので情報として残しているだけ。
- `offers`: price `0` / priceCurrency `JPY`
- `downloadUrl` / `sameAs`: App Store URL、`image`: 実際のアプリアイコン、`url`: このページ自身

### aggregateRating / review を入れていない理由

Googleの Software app 仕様（2026-09-05 参照 / ページ表記 Last updated 2025-12-10 UTC）の
**Required properties** は、原文で次の3項目が並んでいる。

| Required properties | 内容 |
|---|---|
| `name` | アプリ名 |
| `offers.price` | 価格（無料なら `0`） |
| **Rating or review** | "A rating or review of the app. **You must include one of the following properties:**" として `aggregateRating` または `review` |

`applicationCategory` と `operatingSystem` は Recommended properties 側。
つまり評価情報は現時点でも Required 扱いであり、
**このページはリッチリザルトの要件を満たしていない。**

それでも入れないのは、事実として確認できる評価データがないため。
評価・レビュー・DL数・受賞歴を捏造してまでリッチリザルトを狙わない、という判断。
実際の評価が集まった時点で `aggregateRating` を追加すれば要件を満たせる。

リッチリザルトに出なくても、JSON-LD自体はページ内容と一致した事実のみで構成してあり、
`name` / `offers.price` / `applicationCategory` / `operatingSystem` は仕様どおりに入っている。

公開後に [Rich Results Test](https://search.google.com/test/rich-results) や
[Schema Markup Validator](https://validator.schema.org/) で確認できる。

FAQPage構造化データは追加していない（表示目的だけの追加はせず、可視本文の分かりやすさを優先）。

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

## 公開後にGoogleへ認識させる手順（公開してから実施）

**公開前の現在は、Search Consoleの変更もインデックス登録のリクエストも行わないこと。**
以下はページを公開したあとの作業。

1. [Google Search Console](https://search.google.com/search-console) にサイトを登録し、所有権を確認する
   （GitHub Pagesのサブディレクトリ配信のため、URLプレフィックス
   `https://isagiyoi.github.io/tabeporu-support/` で登録する）
2. URL検査ツールで `https://isagiyoi.github.io/tabeporu-support/app.html` を検査し、
   クロール・インデックスの可否とレンダリング結果を確認する
3. 問題がなければ「インデックス登録をリクエスト」する
4. `https://isagiyoi.github.io/robots.txt` がGooglebotをブロックしていないことを確認する
   （2026-09-05 時点では404＝ブロックなし。将来ルートに `robots.txt` が置かれた場合は要確認）
5. `app.html` の `canonical` が公開URL自身
   （`https://isagiyoi.github.io/tabeporu-support/app.html`）を指していることを確認する
6. サイトに `sitemap.xml` を用意する場合は `app.html` を含める
   （2026-09-05 時点ではsitemapなし。3ページだけなので必須ではない）
7. title / meta description / 構造化データを
   [Rich Results Test](https://search.google.com/test/rich-results) 等で確認する
8. 公開後しばらくしてから、**Search Console → 検索パフォーマンス**で検索流入を確認する。
   AI Mode / AI Overviews 経由の流入も、専用レポートではなくこの検索パフォーマンス
   （検索タイプ「ウェブ」）の集計に含まれる。Googleは
   [AI features and your website](https://developers.google.com/search/docs/appearance/ai-features)
   で「AI機能に表示されたサイトもSearch Consoleの全体の検索トラフィックに含まれ、
   Performance reportの"Web" search typeで集計される」と明記している（2026-09-05 参照）

### 公開後に検討してよいこと（今回は未実施）

- 紹介ページを `/`（トップ）に置きたい場合は、サポートページの移設が必要になる。
  現在の `index.html` は App Store Connect に Support URL として登録済みのため、
  URLを変えるなら App Store Connect 側の登録変更もセットで行うこと。
- OGP画像は現在アプリアイコン（512px・正方形）を指定している。横長のOGP画像を用意する場合は差し替える。
