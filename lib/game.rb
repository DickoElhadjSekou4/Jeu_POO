class Game
  attr_accessor :human_player, :players_left, :enemies_in_sight

  def initialize(name)
    @human_player = HumanPlayer.new(name)
    @players_left = 10        # nombre total de joueurs à éliminer pour gagner
    @enemies_in_sight = []    # ennemis visibles au début
  end

  #  Méthodes publiques
  def is_still_ongoing?
    @human_player.life_points > 0 && (@players_left > 0 || !@enemies_in_sight.empty?)
  end

  def show_players
    puts "Etat du joueur :"
    @human_player.show_state
    puts "Il reste #{@enemies_in_sight.size + @players_left} ennemis à combattre"
  end

  def new_players_in_sight
    if @enemies_in_sight.size == @players_left
      puts "Tous les joueurs sont déjà en vue !"
      return
    end

    dice = rand(1..6)
    case dice
    when 1
      puts "Aucun nouvel ennemi n'arrive..."
    when 2..4
      add_new_enemy
    when 5..6
      add_new_enemy
      add_new_enemy
    end
  end

  def menu
    puts "\nQuelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"

    puts "\nattaquer un joueur en vue :"
    @enemies_in_sight.each_with_index do |enemy, index|
      puts "#{index} - #{enemy.name} a #{enemy.life_points} points de vie"
    end
  end

  def menu_choice(choice)
    case choice
    when "a"
      @human_player.search_weapon
    when "s"
      puts @human_player.search_health_pack
    else
      index = choice.to_i
      if index >= 0 && index < @enemies_in_sight.size
        @human_player.attacks(@enemies_in_sight[index])
        if @enemies_in_sight[index].life_points <= 0
          kill_player(@enemies_in_sight[index])
        end
      else
        puts "Choix invalide !"
      end
    end
  end

  def enemies_attack
    puts "\nLes autres joueurs t'attaquent !"
    @enemies_in_sight.each do |enemy|
      enemy.attacks(@human_player) if enemy.life_points > 0
    end
  end

  def kill_player(player)
    puts "Le joueur #{player.name} a été tué !"
    @enemies_in_sight.delete(player)
    @players_left -= 1
  end

  private

  def add_new_enemy
    return if @enemies_in_sight.size >= @players_left
    random_name = "joueur_#{rand(1000..9999)}"
    new_enemy = Player.new(random_name)
    @enemies_in_sight << new_enemy
    puts "Un nouvel ennemi arrive : #{random_name} !"
  end
end
