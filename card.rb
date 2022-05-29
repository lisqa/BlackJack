require_relative 'player'
require_relative 'accessors'

class Card
  attr_accessor :number, :suit, :value
  extend Accessors

  attr_accessor_with_history :card
  
  @@numbers_of_cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace']  
  @@suits_of_cards = ['+', '^', '<3', '<>']
  @@values_of_cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, [1, 11]]

  def initialize
    @number = @@numbers_of_cards[rand(@@numbers_of_cards.length)]
    @suit = @@suits_of_cards[rand(@@suits_of_cards.length)]
  end

  def self.newcard
    card = Card.new unless attr_accessor_with_history.include?(card)
  end

  def value(player) 
    if @number != 'ace'
      @value = @@values_of_cards[@@numbers_of_cards.index(@number)]
    else
      if player.cards.index(self) == 0
        if player.cards[1].number != 'ace'
          (21 - player.cards[1].value(player)) >= 11 ? @value = 11 : @value = 1
        else 
          @value = 11
        end
      elsif player.cards.index(self) == 1
        if player.cards[0].number != 'ace'
          (21 - player.cards[0].value(player)) >= 11 ? @value = 11 : @value = 1
        else 
          @value = 1
        end
      elsif player.cards.index(self) == 2
        (21 - player.cards[0].value(player) - player.cards[1].value(player)) >= 11 ? @value = 11 : @value = 1
      end
    end
  end
end
