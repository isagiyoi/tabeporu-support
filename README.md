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
- 画像は `assets/` 配下（アプリアイコン、端末スクリーンショットのWeb用縮小版、OGP画像）
- バージョン番号に依存する記述は入れていない（アプリ更新のたびに直す必要がない）

### 構成

Hero → 今日どこで食べる？ → いつものお店から、今日の一軒。 → 使い方はシンプル。 →
いつものお店を、まとめて登録。 → 行ったお店を、カレンダーで振り返る。 →
静かに使えるアプリです。 → 新しいお店を探すより、好きなお店をもっと楽しむ。 → 最後のCTA → フッター

### 素材の出どころ

| 用途 | 元ファイル |
|---|---|
| スクリーンショット6枚 | `Tabeporu-Release-Assets/v1.1-final-listing-20260905-184647/screenshots/raw/`（Simulatorで撮った**端末そのままの画面**） |
| アプリアイコン | `EncoreEats/Assets.xcassets/AppIcon.appiconset/AppIcon.png`（リリース中の実アイコン） |
| OGP画像 | 上記2つから `tools/make-ogp.swift` で生成 |

いずれも元ファイルは変更していない。Web用に `sips` で縮小したコピーだけを `assets/` に置いている
（スクリーンショットは幅607px = 表示約300pxに対して2x、アイコンは32/180/512px）。

**App Store提出用の合成画像（`screenshots/ja/`）は使っていない。**
あれは見出しコピーと円弧を焼き込んだマーケティング用の画像で、
Webページ側にも同じ見出しがあるため、同じ文言が二重に出てしまう。
Webでは `raw/` の端末スクリーンショットを使い、見出しはページ側のHTMLで持つ。

新しいロゴ・イラスト・料理写真・人物写真・ストック画像は使っていない。

### OGP画像

```bash
swift tools/make-ogp.swift .
```

`assets/og/ogp-1200x630.png`（1200x630・アルファなし）を作る。
配色・円弧・書体は `app.html` と同じ考え方で、素材はリポジトリ内の実アイコンと
実スクリーンショットだけを使う。文言はページの見出しと揃えている。

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
| 画像 | 7枚すべてにalt、width/height指定、Hero以外はlazy loading（上部バーのアイコンは装飾なので `alt=""`） |
| 折り返し | 320 / 375 / 390 / 768 / 1280px で語中改行・行頭の句読点なし |
| コントラスト | 本文11.59 / 補助文5.07 / リンク5.29 / ブランド名5.18 / CTA 5.92（すべてAA以上） |
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

## 改善（第2版）でやったこと

初版の公開後に、内容とデザインを見直した。

**内容**

- 推薦の説明を「訪問の記録などをもとに」から、実際の判断材料
  （前に行ってからの間隔・時間帯・現在地からの近さ）へ具体化した。
  内部スコアの数値は出さない。
- アプリが実際に表示する「すすめる理由」の文言
  （「そろそろ、また行きたくなる頃。」など）をそのまま載せた。
  これは実在するUI文言で、創作ではない。
- **iOS 26.0以上・iPhone専用**であることを明記した（ヒーローと基本情報の両方）。
  それまではApp Storeへ行くまで対応OSが分からなかった。
- 「行ってみたいお店」も登録できることに触れ、質問を1つ追加した。

**デザイン**

- スクリーンショットをApp Store用の合成画像から**端末そのままの画面**へ差し替えた
  （見出しの二重表示を解消。詳細は「素材の出どころ」）。
- ヒーローとその直後で同じ画像を2回使っていたのをやめ、Core Valueを2枚にした。
- 同じ見た目のセクションが続かないよう、2箇所に全幅の背景帯（`.band`）を入れた。
- 円弧が画面外へ逃げてほとんど見えていなかったので、上部を横切る位置に直した。
- OGPを正方形アイコンから横長1200x630へ変更し、`twitter:card` を
  `summary_large_image` にした。

**技術**

- `<span>` の中に `<h3>` を入れていた不正なネストを `<div>` へ直した。
- ヒーロー画像に `fetchpriority="high"`、各画像に `decoding="async"` を付けた。
- 画像の実寸が 607x1319 になったため `width` / `height` を合わせた。

## 仕上げ（第3版）でやったこと

見た目の作り込み。内容そのものは変えていない。

**日本語の折り返し**

- 折り返しが起きうる文をすべて文節ごとの `<span class="nb">`（`display:inline-block`）に分けた。
  行が変わるのは必ず文節の切れ目になる。
- `line-break:strict` で禁則を厳格にし、見出しは `text-wrap:balance`、本文は `text-wrap:pretty`。
- 見出しと導入文に `font-feature-settings:"palt"` を掛け、日本語の字間を詰めた。
- 本文の一行は35文字程度で頭打ちにした（`max-width:35em`）。
- 320 / 375 / 390 / 768 / 1280px で全テキストの行分割を1文字ずつ計測し、
  語中改行・行頭の句読点が1件も無いことを確認した。

修正した具体例（いずれも第2版までは語中で切れていた）:

| 箇所 | 修正前 | 修正後 |
|---|---|---|
| ヒーロー | 「…提案する**iPhone / アプリ**です。」 | 「…提案する / iPhoneアプリです。」 |
| いつものお店から | 「…位置情報を許可**し / て**いれば」 | 「位置情報を許可していれば、」で改行 |
| タベポルについて | 「…探すことよりも、**い / つ**ものお店」 | 「新しい飲食店を探すことよりも、」で改行 |
| 使い方 | 「よく行くお店をまとめて追加しま / す。」 | 「よく行くお店を / まとめて追加します。」 |
| 基本情報 | 「いつものお店から**今 / 日**行く一軒」 | 狭い画面では項目名の下に値を置く形へ |

**タイポグラフィと余白**

- 見出しを大きくし、行間・字送りを日本語向けに詰めた（h1は最大4rem、行間1.16）。
- セクションの余白を広げた（デスクトップ88px→116px）。
- 本文の行間を1.75→1.8に。

**細部**

- スクリーンショットの角丸を実機の比率（表示幅の約14%）に合わせ、
  1pxの縁と3枚重ねの影を付けた。
- ボタンを角丸16pxから完全な丸（pill）へ。
- 「静かに使えるアプリです。」の箇条書きの記号を、文字の「—」から描画した罫に変えた
  （読み上げに余計な文字が混ざらないようにするため）。
- ヒーローを過ぎると上部バーが出るようにした（すりガラス。App Storeへの導線を常に残す）。
- スクロールに合わせて各要素が静かに現れるようにした。
  `prefers-reduced-motion` のときは何も動かさず、JSが動かない環境でも内容は最初から見える。

**直したバグ**

- 円弧が第2版の公開時点から透明になっていた。
  `.arcs span` の `border:...transparent`（詳細度2）が `.arc-warm`（詳細度1）の色指定に勝っていたため。
  セレクタを `.arcs .arc-warm` にして解決。
- ブランド名「タベポル」の文字色が背景に対して3.07で、WCAG AAの4.5に届いていなかった。
  装飾用の `--warm` とは別に、文字用の `--warm-text`（5.18）を用意した。

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
- 画像はPNGのままで合計約880KB。WebP / AVIF にすれば半分以下になるが、
  この環境には `cwebp` / `avifenc` / `pngquant` が無く、`sips` もWebP非対応のため見送っている。
