# README

## 1.アプリ名
## 風語　翔(かぜがたり かける)

![風語翔](https://user-images.githubusercontent.com/63190202/89417412-9e900d00-d769-11ea-8345-8327413db778.JPG)

## 2.機能
### 埼玉県南部で当日の6時間毎の降水確率が30%以上の場合、AM6:30頃にお知らせしてくれるLINE BOTです。

## 3.使い方
### https://lin.ee/LTehhju
 上記URLからリンク先に遷移後、友達登録をしていただければ利用可能です。

![風語 翔](https://user-images.githubusercontent.com/63190202/90083264-025b9c80-dd4d-11ea-9a64-8ab5fb20c5ab.JPG)

- 「明日」,「明後日」等の特定のワードに対して反応してそれぞれ該当する日に雨が降るかを返信します。

## 4.作成理由
- 筋トレ初心者用のサポート用のLINE BOTを作成したいと思いましたが、まずはrailsでLINE BOTがどのような仕組みで作れるのか知りたかった。

## 5.使用技術
### 言語
- ruby,ruby on rails
### Gem
- line-bot-api
### PaaS
- heroku

## 6.DB設計
### usersテーブル
|Column|Type|Options|
|------|----|-------|
|line_id|string|null: false|

## 7.今後
- 今回作成するにあたりLINE BOTの大まかな仕組みを把握できた為、他にもLINE BOTを作成予定です。
- 現在筋トレ初心者向けサポートLINE BOT「筋トレする造(ぞう)」製作中


