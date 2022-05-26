require_relative 'card'

class Player
  attr_accessor :name, :summ, :cards, :bank, :value, :card
  @@players = []
  @@values_of_cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, [1, 11]]

  def initialize(name)
    @name = name
    @cards = []
    @@players << self
  end

  def self.all
    @@players
  end

  def cards_summ
    @summ = 0
    @cards.each { |card| @summ += value(card) }
    return @summ
  end

  def add_card
    card = Card.newcard
    @cards << card
  end

  def value(card) 
    if card.number != 'ace'
      @value = @@values_of_cards[card.ind(card)]
    else
      i = cards.index(card)
      if i == 0
        if self.cards[1].number != 'ace'
          (21 - value(cards[1])) >= 11 ? @value = 11 : @value = 1
        else 
          @value = 11
        end
      elsif i == 1
        if self.cards[0].number != 'ace'
          (21 - value(cards[0])) >= 11 ? @value = 11 : @value = 1
        else 
          @value = 1
        end
      elsif i == 2
        (21 - value(cards[0]) - value(cards[1])) >= 11 ? @value = 11 : @value = 1
      end
    end
  end
end
