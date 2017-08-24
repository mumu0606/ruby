"# -*- encoding: utf-8 -*-"
# answer for challenge by Ateam https://codeiq.jp/q/3273
# compute least sum of importance when sum of price is over targe price
# compute by dynamic programming

$target_value
# key => price, value => importance
$hash_goods = {}

# key => sum_price, value => sum_importance
$hash_dp = { 0 => 0 }

# 入力処理
def get_datas_from_input
    $target_value = gets.chomp.split[1].to_i
    while line = gets
        break if line.chomp.empty?
        splited_line = line.chomp.split
        $hash_goods[splited_line[0].to_i] = splited_line[1].to_i
    end
end

# DP
def compute_dp
    $hash_goods.each do |price, importance|
        # 新しいハッシュに結果を入れて後から結合することで、ループ中に探査済みの結果を変更してしまう恐れがなくなる
        hash_new_dp = {}
        $hash_dp.each do |sum_price, sum_importance|
            new_sum_price              = sum_price + price
            new_sum_importance         = sum_importance + importance
            hash_new_dp[new_sum_price] = new_sum_importance
        end
        $hash_dp.merge! (hash_new_dp) do |key, oldval, newval|
            newval < oldval ? newval : oldval
        end
    end
end

if __FILE__ == $0
    get_datas_from_input
    compute_dp
    clear_hash = $hash_dp.select do |price, value|
        price >= $target_value
    end
    sorted_hash = clear_hash.sort {|(k1, v1), (k2, v2)| v1 <=> v2 }
    p sorted_hash.first[1]
end

