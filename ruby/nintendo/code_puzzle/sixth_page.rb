require './third_page.rb'
require './fifth_page.rb'
require './ordinal.rb'

answer = $grid.split('').values_at(*$ordinal[0..21]).each_slice(2).map{|x, y| $plain_text.cell(x, y)}.join

p answer