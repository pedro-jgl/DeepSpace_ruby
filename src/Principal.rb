# encoding: utf-8

require_relative 'Loot' 
require_relative 'CombatResult'
require_relative 'Dice'
require_relative 'GameCharacter'
require_relative 'ShieldBooster'
require_relative 'ShotResult'
require_relative 'SuppliesPackage'
require_relative 'Weapon'
require_relative 'WeaponType'


#Dir["./*"].each {|file| require_relative file }


VECES_A_TIRAR = 100
PLAYERS = 3
SPEED = 0.25


lote = Loot.new(1,2,3,4,5)
dado1 = Dice.new
escudo2 = ShieldBooster.new("nombre", 0.5, 0)
paquete2 = SuppliesPackage.new(2.0,2.0,2.0)
arma2 = Weapon.new("Pistola", WeaponType::LASER, 1)

puts lote.inspect
puts dado1.inspect
puts dado1.initWithNHangars
puts dado1.initWithNWeapons
puts dado1.initWithShields
puts dado1.whoStarts(PLAYERS)
puts dado1.firstShot
puts dado1.spaceStationMoves(SPEED)

