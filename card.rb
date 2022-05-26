require_relative 'player'
require_relative 'accessors'

class Card
  attr_accessor :number, :suit
  extend Accessors

  attr_accessor_with_history :card
  
  @@numbers_of_cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace']  
  @@suits_of_cards = ['+', '^', '<3', '<>']

  def initialize
    @number = @@numbers_of_cards[rand(@@numbers_of_cards.length)]
    @suit = @@suits_of_cards[rand(@@suits_of_cards.length)]
  end

  def self.newcard
    card = Card.new unless attr_accessor_with_history.include?(card)
  end

  def ind(card)
    @@numbers_of_cards.index(card.number)
  end
end
