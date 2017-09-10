# answer_code for _nin/ten/do_co/de_pu/zzle
# 検索対策のため / 区切り
# 回答のために変更した箇所にwirtten by hirokiと書いてあります

require 'set'
require './utility.rb'

module NumberPlace
  class Solver
    def initialize(grid)
      @grid = grid
    end

    ALL_NUMBERS = Set.new(1..9)

    # 縦一列を見て空欄に当てはまる数字を探す
    def list_candidates_column(x)
      ALL_NUMBERS - (1..9).map{|i| @grid.cell(x,i).to_i}
    end

    # 横一列を見て空欄に当てはまる数字を探す
    def list_candidates_raw(y)
      ALL_NUMBERS - (1..9).map{|i| @grid.cell(i,y).to_i}
    end

    def list_candidates_box(x,y)
      ALL_NUMBERS - @grid.get_box_by_pos(x, y)
    end

    def list_candidates(x, y)
      list_candidates_column(x) & list_candidates_raw(y) & list_candidates_box(x,y)
    end

    # * 候補が一つしかないマスを埋める
    # * writte by hiroki 2017/08/27
    def solve_simple()
        (1..9).each do |x|
            (1..9).each do |y|
                # すでに埋まっているマスは何もしない
                if @grid.cell(x, y).to_i != 0
                    next
                end

                # 候補が1個だけなら即挿入
                candidates = list_candidates(x, y)
                if candidates.count == 1
                  @grid.set_cell(x, y, candidates.first)
                end
            end
        end
    end

    def solve_with_backtracking()
      solve_simple() #答えが確定しているところは解く

      next_zero = @grid.index("0")
      return true if next_zero.nil? #0がなし→回答発見

      #ここから再帰
      #0のマスに対して候補を仮置き
      x, y = @grid.index2pos(next_zero)
      list_candidates(x, y).each do |k|
        grid_clone = @grid.clone #グリッドのコピー
        @grid.set_cell(x, y, k)

        if solve_with_backtracking()
          return true
        end

        @grid = grid_clone
      end
      return false
    end

    def solve()
      solve_with_backtracking()
      @grid
    end

    def show_box(x,y)
      @grid.index2box(@grid.pos2index(x,y))
    end

    def show_grid()
      puts @grid.to_grid
    end
  end
end