# answer_code for _nin/ten/do_co/de_pu/zzle 
# 検索対策のため / 区切り
# 回答のために変更した箇所にwirtten by hirokiと書いてあります

require './first_page.rb'

class String
    @@grid_size = 9

    # ボックスの幅 written by hiroki
    BOX_SIZE = 3

    def self.grid_size() @@grid_size end

    def self.grid_size=(n) @@grid_size = n end

    def pos2index(x, y)
      # shogi-style coordinate system
      # (9,1) (8,1) (7,1) .. (1,1)
      # ..
      # (9,9) .. (3,9) (2,9) (1,9)
      y.to_i * @@grid_size - x.to_i
    end

    def index2pos(n)
      [@@grid_size - n%@@grid_size, n/@@grid_size + 1]
    end

    # * posから属するboxの情報を取得する
    # * @param x
    # * @param y
    # * return box set
    # * written by hiroki
    def get_box_by_pos(x, y)
        # boxの中のマスのうち最小のindexを求める
        # pos計算。計算の仕方は要仕様確認。
        box_first_x = (x + 2) / BOX_SIZE * BOX_SIZE
        box_first_y = (y - 1) / BOX_SIZE * BOX_SIZE + 1

        # indexへ変換。ボックス内のマス全てのindexも取得。
        box_first_index = pos2index(box_first_x, box_first_y)
        box_indexes     = Set[box_first_index,      box_first_index + 1,  box_first_index + 2,
                              box_first_index + 9,  box_first_index + 10, box_first_index + 11,
                              box_first_index + 18, box_first_index + 19, box_first_index + 20]

        box_numbers = Set.new()
        box_indexes.each do |box_index|
            box_numbers.add(self[box_index, 1].to_i)
        end

        return box_numbers
    end

    def cell(x, y)
      self[pos2index(x, y),1]
    end

    def set_cell(x, y, c)
      self[pos2index(x, y)] = c.to_s
    end

    def to_grid
      self.gsub(/.{#{@@grid_size}}/, "\\0\n")
    end
end


# for compatibility

unless String.method_defined?(:bytes)
  class String
    def bytes
      ret = []
      each_byte{|b| ret << b}
      ret
    end
  end
end

unless Array.method_defined?(:rotate)
  class Array
    def rotate(n)
      slice(n%size..-1) + slice(0, n%size)
    end
  end
end

unless Enumerable.method_defined?(:each_slice)
  module Enumerable
    def each_slice(n)
      if block_given?
        args = []
        each {|v|
          args << v
          if args.size == n
            yield args
            args = []
          end
        }
        yield args unless args.empty?
      else
        ret = []
        each_slice(n){|arr| ret << arr}
        ret
      end
    end
  end
end