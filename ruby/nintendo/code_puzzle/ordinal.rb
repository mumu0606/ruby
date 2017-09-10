# 素数を順に22個格納した配列を作成します
$ordinal = Array.new()

def make_prime_ary()
    ordinal_count = 0
    i = 2
    while ordinal_count < 22
        is_prime = (2...i).all? {|divisor|
            i % divisor != 0
        }

        if is_prime
            $ordinal.push(i)
            ordinal_count += 1
        end
        i += 1
    end
end

make_prime_ary
p $ordinal