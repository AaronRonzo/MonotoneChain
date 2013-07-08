module MonotoneChain
  def self.find_convex_hull(points)
    points.sort!.uniq!

    lower = []
    points.each do |point|
      lower.pop while is_clockwise?(lower, point)
      lower.push point
    end

    upper = []
    points.reverse_each do |point|
      upper.pop while is_clockwise?(upper, point)
      upper.push point
    end

    hull = lower[0...-1] + upper[0...-1]
  end

  def self.cross_product(o, a, b)
    (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0])
  end

  def self.is_clockwise?(hull_part, test_point)
    is_necessary_length = hull_part.length > 1
    return false unless is_necessary_length
    cross_product(hull_part[-2], hull_part.last, test_point) <= 0
  end
end
