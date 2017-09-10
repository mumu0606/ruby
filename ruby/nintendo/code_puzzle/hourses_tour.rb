require 'set'
require './utility.rb'

module HoursesTour
    class Solver
        def initialize(grid)
          @grid     = grid
          @path     = []
          @solutions = []
        end

        # * 2点間pos1, pos2が移動できるか判定する
        # * param  x1, y1: pos1の座標
        # * param  x2, y2: pos2の座標
        # * return bool
        def can_move?(x1, y1, x2, y2)
            # 周囲1マスにある
            distance = Math.sqrt((x1 - x2)**2 + (y1 - y2)**2)
            if distance == 1
                return true
            end

            # 斜め方向にある（x方向とy方向の絶対値が等しい）
            abs_distance_x = (x1 - x2).abs
            abs_distance_y = (y1 - y2).abs
            if abs_distance_x == abs_distance_y && abs_distance_x != 0
                return true
            end

            return false
        end

        # * ある点から移動可能な座標を全て列挙する
        # * param  x, y
        # * return array
        def movable_positions(x, y)
            ary_movable_points = []
            (1..9).each do |tx|
                (1..9).each do |ty|
                    if can_move?(x, y, tx, ty)
                        ary_movable_points.push([tx, ty])
                    end
                end
            end
            return ary_movable_points
        end

        def solve_with_backtracking(x, y, k)
            @path << [x, y]
            p @path
            if k == 9
                @solutions << @path.clone if can_move?(x, y, @path[0][0], @path[0][1])
            else
                movable_positions(x, y).each{ |nx, ny|
                    if @grid.cell(nx, ny).to_i == k+1
                        solve_with_backtracking(nx, ny, k+1)
                    end
                }
            end
            @path.pop
        end

        def solve(x, y)
            solve_with_backtracking(x, y, 1)

            return @solutions
        end
    end
end