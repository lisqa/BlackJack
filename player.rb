require_relative 'card'

class Player
  attr_accessor :name, :summ, :cards, :bank
  @@players = []

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
    @cards.each { |card| @summ += card.value(self) }
    return @summ
  end

  def add_card
    @cards << Card.newcard
  end
end
