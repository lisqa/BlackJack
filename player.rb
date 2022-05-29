require_relative 'card'

class Player
  attr_accessor :name, :cards, :bank
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
    @cards.sum { |card| card.value(self) }
  end

  def add_card
    @cards << Card.newcard
  end
end
