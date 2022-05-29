require_relative 'player'
require_relative 'accessors'

class Card
  attr_accessor :number, :suit
  attr_reader :value
  extend Accessors

  attr_accessor_with_history :card
  
  NUMBERS_OF_CARDS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace']  
  SUITS_OF_CARDS = ['+', '^', '<3', '<>']
  VALUES_OF_CARDS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, [1, 11]]
  MAX_POINT = 21
  MAX_ACE_VALUE = 11
  MIN_ACE_VALUE = 1

  def initialize
    @number = NUMBERS_OF_CARDS[rand(NUMBERS_OF_CARDS.length)]
    @suit = SUITS_OF_CARDS[rand(SUITS_OF_CARDS.length)]
  end

  def self.newcard
    card = Card.new unless attr_accessor_with_history.include?(card)
  end


  def value(player) 
    @number != 'ace' ? VALUES_OF_CARDS[NUMBERS_OF_CARDS.index(@number)] : case player.cards.index(self)
      
      when 0 
        if player.cards[1].number != 'ace'
          (MAX_POINT - player.cards[1].value(player)) > (MAX_POINT - MAX_ACE_VALUE) ? MAX_ACE_VALUE : MIN_ACE_VALUE
        else 
          MAX_ACE_VALUE
        end
      when 1
        if player.cards[0].number != 'ace'
          (MAX_POINT - player.cards[0].value(player)) > (MAX_POINT - MAX_ACE_VALUE) ? MAX_ACE_VALUE : MIN_ACE_VALUE
        else 
          MIN_ACE_VALUE
        end
      when 2
        (MAX_POINT - player.cards[0].value(player) - player.cards[1].value(player)) > (MAX_POINT - MAX_ACE_VALUE) ? MAX_ACE_VALUE : MIN_ACE_VALUE
      end
  end





=begin
if @number != 'ace' 
      @value = VALUES_OF_CARDS[NUMBERS_OF_CARDS.index(@number)]
    else

  def value(player) 
    if @number != 'ace'
      @value = VALUES_OF_CARDS[NUMBERS_OF_CARDS.index(@number)]
    else
      if player.cards.index(self) == 0
        if player.cards[1].number != 'ace'
          (MAX_POINT - player.cards[1].value(player)) > (MAX_POINT - MAX_ACE_VALUE) ? @value = MAX_ACE_VALUE : @value = MIN_ACE_VALUE
        else 
          @value = MAX_ACE_VALUE
        end
      elsif player.cards.index(self) == 1
        if player.cards[0].number != 'ace'
          (MAX_POINT - player.cards[0].value(player)) > (MAX_POINT - MAX_ACE_VALUE) ? @value = MAX_ACE_VALUE : @value = MIN_ACE_VALUE
        else 
          @value = MIN_ACE_VALUE
        end
      elsif player.cards.index(self) == 2
        (MAX_POINT - player.cards[0].value(player) - player.cards[1].value(player)) > (MAX_POINT - MAX_ACE_VALUE) ? @value = MAX_ACE_VALUE : @value = MIN_ACE_VALUE
      end
    end
  end
=end
end
