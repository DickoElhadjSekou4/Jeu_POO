require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------"
puts "| Bienvenue sur 'ILS VEULENT TOUS MA POO' ! |"
puts "| Le but du jeu est d'être le dernier survivant ! |"
puts "------------------------------------------------"

# Initialisation du joueur humain
puts "Quel est ton prénom ?"
user_name = gets.chomp
user = HumanPlayer.new(user_name)

# Initialisation des ennemis
player1 = Player.new("Josiane")
player2 = Player.new("José")
enemies = [player1, player2]
#Bouble while 
while user.life_points > 0 && enemies.any? { |enemy| enemy.life_points > 0 }

  puts "\nEtat du joueur :"
  user.show_state

  # Menu dynamique
  puts "\nQuelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner"

  alive_enemies = enemies.select { |enemy| enemy.life_points > 0 }
  if alive_enemies.empty?
    break  # plus d'ennemis vivants → fin de la boucle
  end

  puts "\nattaquer un joueur en vue :"
  alive_enemies.each_with_index do |enemy, index|
    puts "#{index} - #{enemy.name} a #{enemy.life_points} points de vie"
  end

  print "\n> "
  choice = gets.chomp

  # Actions du joueur
  case choice
  when "a"
    puts user.search_weapon
  when "s"
    puts user.search_health_pack
  else
    if choice.to_i.to_s == choice && alive_enemies[choice.to_i]
      user.attacks(alive_enemies[choice.to_i])
    else
      puts "Choix invalide !"
    end
  end

  # Les ennemis attaquent uniquement s'il en reste
  if alive_enemies.any?
    puts "\nLes autres joueurs t'attaquent !"
    alive_enemies.each do |enemy|
      enemy.attacks(user)
    end
  end

end

# Fin de la partie
puts "\nLa partie est finie"
if user.life_points > 0
  puts "BRAVO ! TU AS GAGNE !"
else
  puts "Loser ! Tu as perdu !"
end
