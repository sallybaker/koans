require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
# 
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def score(dice)
  # You need to write this method 
  dice.sort 
  points = 0 
  ones = 0
  twos = 0
  threes = 0 
  fours = 0 
  fives = 0
  sixes = 0
  for x in dice 
    if x == 5
      points += 50
      fives += 1
    elsif x == 1
      points += 100
      ones += 1
    elsif x == 2
      twos += 1
    elsif x == 3
      threes += 1
    elsif x == 4
      fours += 1
    elsif x == 6 
      sixes += 1
    else
      points += 0
    end
    if fives == 3
      points = points - 150 
      points += 500 
      fives = 0 
    elsif ones == 3 
      points = points - 300 
      points += 1000 
      ones = 0
    elsif twos == 3
      points += 100 * 2
      twos = 0
    elsif threes == 3
      points += 100 * 3
      threes = 0 
    elsif fours == 3
      points += 100 * 4
      fours = 0 
    elsif sixes == 3 
      points += 100 * 6
      sixes = 0 
    else
      points += 0
    end
  end
  return points
end

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([0])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
    assert_equal 1100, score([1,1,1,1])
    assert_equal 1200, score([1,1,1,1,1])
    assert_equal 1150, score([1,1,1,5,1])
  end

end
