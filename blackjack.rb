require_relative 'card'
require_relative 'player'

class Play
  attr_accessor :diler, :player, :game_bank

  def run
    bank(100)
    puts "Your bank: #{@player.bank}"    
    loop do 
      start
      playplayer
      break if @player.bank == 0 || @diler.bank == 0
    end
    puts "
    --Game over. Would you like to play again? 
          1 - yes
          2 - no"
    run if gets.chomp == '1'
  end

  def hello
    @diler = Player.new('diler')
    puts "What is your name?"
    @player = Player.new(gets.chomp)
    @game_bank = 0
  end

  private

  def bank(cash)
    Player.all.each { |player| player.bank = cash.to_i }
  end

  def start
    puts "
    --New round--"
    Player.all.each { |player| player.cards = [] }
    2.times do
      Player.all.each { |player| player.add_card }
    end
    Player.all.each { |player| player.bank -= 10 }
    @game_bank = 20
    putscards(@player)
  end

  def liedown
    if (21 - @diler.cards_summ).abs > (21 - @player.cards_summ).abs
      @player.bank += @game_bank
      puts "--Round over! You win! Your bank: #{@player.bank}" 
      putscards(@diler)
    elsif (21 - @player.cards_summ).abs > (21 - @diler.cards_summ).abs
      @diler.bank += @game_bank
      puts "--Round over! You lose :(. Your bank: #{@player.bank}"
      putscards(@diler)
    else 
      Player.all.each { |player| player.bank += (@game_bank / 2) }
      puts "--Round over! Friendship wins! Your bank: #{@player.bank}" 
      putscards(@diler)
    end
  end

  def playdiler
    if @diler.cards_summ >= 17
      playplayer
    else
      @diler.add_card
      playplayer
    end
  end

  def playplayer
    if @player.cards.length == 3 || diler.cards.length == 3
      puts "Cards > 3. Liedown automatically."
      liedown
    else
      puts "Make choice: 
              1 - skip 
              2 - take a card 
              3 - lie down"
      choice = gets.chomp.to_i
      case choice
        when 1
          playdiler
        when 2
          @player.add_card
          putscards(@player)
          playdiler
        when 3
          liedown
        else
          puts "Be careful"
          playplayer
      end
    end
  end

  def putscards(player)
    puts "#{player.name} cards:"
    player.cards.each { |card| puts "#{card.number} #{card.suit}"}
    puts "Summ: #{player.cards_summ}"
  end
end

play1 = Play.new
play1.hello
play1.run
