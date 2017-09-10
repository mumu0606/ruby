def trans_table(key)
  alphabets = ["A".."Z", "a".."z", "0".."9"].map{|r| r.to_a.join}
  alphabets.map{|ab| [ab, ab[key%ab.size..-1] + ab[0, key%ab.size]]}.
    transpose.map{|a| a.join}
end

def decode(the_answer, key)
  the_answer.tr *trans_table(key)
end

def getKey
  (1..25).each do |i|
    key = i
    return key if decode("uvtfuv", key) == "decode"
  end
  puts "invalid decode"
end

if __FILE__ == $0
  key = getKey
  # puts decode("ykkg://tg2.ezekveuf.tf.ag/vekvi", key)
  puts decode('Primenumber', key)
end