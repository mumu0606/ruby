# vigenere.rbを読み込む

# 4文字アルファベットの組み合わせで鍵を生成

# decode_vigenereで暗号文を平文にする

# オラクルと一致するまでこれを繰り返す

# password.rb
require './vigenere.rb'
require './second_page.rb'

ORACLE     = 'have'
$candidate = []
# $candidateの中から目視で正解のパスワードを入力する
$password  = 'read'

def check_sum(s)
  sum = s.bytes.inject(0){|acc,c| acc += c}
  sum % 26 == 0
end

def find_password
    alphabets = [*'a'..'z']
    alphabets.each do |a1|
        alphabets.each do |a2|
            alphabets.each do |a3|
                alphabets.each do |a4|
                    password   = ''
                    password   = a1 + a2 + a3 + a4
                    plain_text = decode_vigenere($text, password)
                    if plain_text.include?(ORACLE) && check_sum(plain_text[1..-1])
                        p "平文: #{plain_text} パスワード: #{password}¥n"
                        $candidate.push(password)
                    end
                end
            end
        end
    end
end

if __FILE__ == $0
    find_password
end


