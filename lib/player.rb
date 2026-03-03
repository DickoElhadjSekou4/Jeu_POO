class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie"
  end

  def gets_damage(damage)
    @life_points -= damage
    @life_points = 0 if @life_points < 0
    puts "le joueur #{@name} a été tué !" if @life_points <= 0
  end

  def compute_damage
    rand(1..6)
  end

  def attacks(player)
    puts "#{@name} attaque #{player.name}"
    damage = compute_damage
    player.gets_damage(damage)
    puts "il lui inflige #{damage} points de dommages"
  end
end
class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    super(name)            # appelle initialize de Player pour le nom
    @life_points = 100     # les humains commencent avec 100 points de vie
    @weapon_level = 1      # arme de base niveau 1
  end

  # Affiche l'état du joueur humain
  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  # Calcule les dégâts infligés, en tenant compte du niveau de l'arme
  def compute_damage
    rand(1..6) * @weapon_level
  end

  # Chercher une nouvelle arme
  def search_weapon
    new_weapon = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon}"
    if new_weapon > @weapon_level
      @weapon_level = new_weapon
      puts "Youpiii ! elle est meilleure que ton arme actuelle : tu la prends."
    else
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  # Chercher un pack de points de vie
  def search_health_pack
    roll = rand(1..6)
    case roll
    when 1
      "Tu n'as rien trouvé..."
    when 2..5
      @life_points += 50
      @life_points = 100 if @life_points > 100
      "Bravo, tu as trouvé un pack de +50 points de vie !"
    when 6
      @life_points += 80
      @life_points = 100 if @life_points > 100
      "Waow, tu as trouvé un pack de +80 points de vie !"
    end
  end
end
