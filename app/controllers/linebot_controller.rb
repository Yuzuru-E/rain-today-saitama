class LinebotController < ApplicationController
  require 'line/bot' 
  require 'open-uri'
  require 'kconv'
  require 'rexml/document'

  protect_from_forgery :except => [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
    events = client.parse_events_from(body)
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          input = event.message['text']
          url  = "https://www.drk7.jp/weather/xml/11.xml"
          xml  = open( url ).read.toutf8
          doc = REXML::Document.new(xml)
          xpath = 'weatherforecast/pref/area[2]/'
          min_per = 30
          case input
          when /.*(明日|あした).*/
            per06to12 = doc.elements[xpath + 'info[2]/rainfallchance/period[2]'].text
            per12to18 = doc.elements[xpath + 'info[2]/rainfallchance/period[3]'].text
            per18to24 = doc.elements[xpath + 'info[2]/rainfallchance/period[4]'].text
            if per06to12.to_i >= min_per || per12to18.to_i >= min_per || per18to24.to_i >= min_per
              push =
                "明日の天気ですね。\n明日は雨が降りそうです(>_<)\n今のところ降水確率はこんな感じです。\n　  6〜12時　#{per06to12}％\n　12〜18時　 #{per12to18}％\n　18〜24時　#{per18to24}％\nまた明日の朝の最新の天気予報で雨が降りそうだったら教えるね！"
            else
              push =
                "明日の天気ですか？\n明日は雨が降らない予定ですよ(^^)\nまた明日の朝の最新の天気予報で雨が降りそうであればお伝えします！"
            end
          when /.*(明後日|あさって).*/
            per06to12 = doc.elements[xpath + 'info[3]/rainfallchance/period[2]l'].text
            per12to18 = doc.elements[xpath + 'info[3]/rainfallchance/period[3]l'].text
            per18to24 = doc.elements[xpath + 'info[3]/rainfallchance/period[4]l'].text
            if per06to12.to_i >= min_per || per12to18.to_i >= min_per || per18to24.to_i >= min_per
              push =
                "明後日の天気ですね。\n何かご予定ありますか？\n明後日は雨が降りそうですね…\n当日の朝に雨が降りそうであればお伝えしますね！"
            else
              push =
                "明後日の天気ですか？\n気が早いですね(^^;)何かご用事ですか？。\n明後日は雨は降らない予定ですね(^^)\nまた当日の朝の最新の天気予報で雨が降りそうでしたらお伝えします！"
            end
          when /.*(風が語りかけます|かぜがかたりかけます).*/
            push =
              "∩( ﾟ∀ﾟ),＜うまい、うますぎる"
          when /.*(埼玉銘菓|さいたまめいか).*/
            push =
              "十万石幔頭\n埼玉銘菓十万石幔頭"
          else
            per06to12 = doc.elements[xpath + 'info/rainfallchance/period[2]l'].text
            per12to18 = doc.elements[xpath + 'info/rainfallchance/period[3]l'].text
            per18to24 = doc.elements[xpath + 'info/rainfallchance/period[4]l'].text
            if per06to12.to_i >= min_per || per12to18.to_i >= min_per || per18to24.to_i >= min_per
              word =
                ["雨だけど元気出して行きましょう！",
                 "雨に負けずファイト！！",
                 "雨だけどあなたの明るさでみんなを元気にしてあげて下さい(^^)"].sample
              push =
                "今日の天気ですか？\n今日は雨が降りそうだから傘があった方が安心ですよ。\n　  6〜12時　#{per06to12}％\n　12〜18時　 #{per12to18}％\n　18〜24時　#{per18to24}％\n#{word}"
            else
              word =
                ["天気もいいから一駅歩いてみるのはどうですか？(^^)",
                 "今日会う人のいいところを見つけて是非その人に教えてあげて下さい(^^)",
                 "素晴らしい一日になりますように(^^)",
                 "雨が降っちゃったらすみません(><;)"].sample
              push =
                "今日の天気ですか？\n今日は雨は降らなさそうですよ。\n#{word}"
            end
          end
        else
          push = "風が語りかける以外はわからないです(；；)"
        end
        message = {
          type: 'text',
          text: push
        }
        client.reply_message(event['replyToken'], message)
      when Line::Bot::Event::Follow
        line_id = event['source']['userId']
        User.create(line_id: line_id)
      when Line::Bot::Event::Unfollow
        line_id = event['source']['userId']
        User.find_by(line_id: line_id).destroy
      end
    }
    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
