# README

## 1.アプリ名
## 風語　翔(かぜがたり かける) (名前の由来は埼玉県民ならご存知のネタから拝借しました。)

![風語翔](https://user-images.githubusercontent.com/63190202/89417412-9e900d00-d769-11ea-8345-8327413db778.JPG)

## 2.機能
### 埼玉県南部で当日の6時間毎の降水確率が30%以上の場合、AM6:30頃にお知らせしてくれるLINE BOTです。

## 3.使い方
### https://lin.ee/LTehhju
 上記URLからリンク先に遷移後、友達登録をしていただければ利用可能です。

※時間の設定は変更いたしました。
![_20200729_084810](https://user-images.githubusercontent.com/63190202/89412086-6b498000-d761-11ea-9571-f3e07577b9cb.JPG)

- 「明日」,「明後日」等の特定のワードに対して反応してそれぞれ該当する日に雨が降るかを返信します。

## 4.作成理由
- 参考:https://ysk-pro.hatenablog.com/entry/railnotice-linebot ゆうすけさん作「今日雨降るよちゃん」の記事を見て、
　初心者むけの筋トレサポート用のLINE BOTを作成したいと思ったが、まずはrailsでLINE BOTがどのような仕組みで作れるのか知りたかった。
- 自分でも使って見たかった為、自分の住んでいる地域に合わせてカスタマイズした。

## 5.使用技術
### 言語
- ruby,ruby on rails
### Gem
- line-bot-api

## 6.DB設計
### usersテーブル
|Column|Type|Options|
|------|----|-------|
|line_id|string|null: false|

## 7.今後
- 今回作成するにあたりLINE BOTの大まかな仕組みを把握できた為、他にもLINE BOTを作成予定です。
- 現在筋トレ初心者向けサポートLINE BOT「筋トレする造(ぞう)」製作中


