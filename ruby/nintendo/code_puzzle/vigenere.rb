# vigenere.rb
# ヴィジュネル暗号周りのコードです

# * ヴィジュネル暗号を解読する
# * @params cipher     : 暗号文
# * @params password   : 鍵となる文字列（大文字、小文字対応)
# * @return plain_text : 平文（小文字）
# * [must]平文は大文字小文字の区別ありでreturnしなければならない
def decode_vigenere(cipher, password)
    alphabets  = [*'a'..'z', *'A'..'Z']
    plain_text = ''
    cipher.split('').each_with_index do |cipher_char, index|
        # アルファベット以外がきたら処理せず平文に加える
        if cipher_char !~ /^[a-zA-Z]/
            plain_text << cipher_char
            next
        end

        # 暗号の文字がアルファベットで何文字目か
        cipher_char_index = alphabets.index(cipher_char) % 26

        # 暗号の文字に対応するパスワードの文字がアルファベットで何文字目か
        # 暗号の10文字目なら 10 % 4 で2文字目が解読のキーとなる
        password_char       = password[index % password.size]
        password_char_index = alphabets.index(password_char) % 26

        # 平文の文字を求める
        plain_char_index = (cipher_char_index - password_char_index) % 26
        # アルファベット配列の26基数以上のときは暗号文字が大文字だったので平文も大文字にする
        is_upcase = (alphabets.index(cipher_char) >= 26)
        if is_upcase
            plain_text << alphabets[plain_char_index].upcase
        else
            plain_text << alphabets[plain_char_index]
        end
    end

    return plain_text
end

if __FILE__ == $0
end