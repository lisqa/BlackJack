require_relative 'card'
require_relative 'player'

class Play
  attr_reader :diler, :player, :game_bank
  MAX_BANK = 100
  STEP_BANK = 10
  MAX_POINT = 21

  def run
    bank(MAX_BANK)
    puts "Your bank: #{@player.bank}"    
    loop do 
      start
      playplayer    
      puts "
      --Round over. Would you like new round? 
          1 - yes
          2 - no"   
      break if @player.bank == 0 || @diler.bank == 0 || gets.chomp == '2' 
    end
    if @player.bank == 0 || @diler.bank == 0
      puts "
      --Game over. Would you like to play again? 
            1 - yes
            2 - no"
      run if gets.chomp == '1'
    end
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
    Player.all.each { |player| player.bank -= STEP_BANK }
    @game_bank = STEP_BANK * 2
    putscards(@player)
  end

  def liedown
    if (MAX_POINT - @diler.cards_summ).abs > (MAX_POINT - @player.cards_summ).abs && @player.cards_summ <= MAX_POINT
      @player.bank += @game_bank
      puts "--Round over! You win! Your bank: #{@player.bank}" 
      putscards(@diler)
    elsif (MAX_POINT - @player.cards_summ).abs > (MAX_POINT - @diler.cards_summ).abs && @diler.cards_summ <= MAX_POINT
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
